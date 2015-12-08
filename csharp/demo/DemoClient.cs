
using System;
using System.IO;
using System.Collections.Generic;

using Google.ProtocolBuffers;
using DeltaVSoft.RCFProto;

class Program
{
    static int Main(string[] args)
    {
        try
        {
            // Configure DLL loading paths for RCFProto_NET.dll and RCFProto_NET_impl.dll.
            DllPathResolver.Resolve(args);

            return Run(args);
        }
        catch (Exception e)
        {
            System.Console.WriteLine(e.Message);
        }
        return 1;
    }
    
    static void PrintRequest(Google.ProtocolBuffers.IMessage request)
    {
        System.Console.WriteLine("*** Sending request ***");
        string strRequest = request.ToString();
        System.Console.WriteLine(strRequest);
    }

    static void PrintResponse(Google.ProtocolBuffers.IMessage response)
    {
        System.Console.WriteLine("*** Sending response ***");
        string strResponse = response.ToString();
        System.Console.WriteLine(strResponse);
    }
   
    // Remote call completion handler.
    public static bool gCallCompleted = false;

    static void OnRpcDone(
        SearchService.Stub  searchService, 
        RcfProtoController  rcfController, 
        SearchRequest       request, 
        SearchResponse      response)
    {
        if (rcfController.Failed)
        {
            System.Console.WriteLine("RPC error: " + rcfController.ErrorText);
        }
        
        gCallCompleted = true;
    }

    // Certificate validation callback.
    static bool OnValidateCertificate(Certificate cert)
    {
        Win32Certificate win32Cert = cert as Win32Certificate;
        if (win32Cert != null)
        {
            System.Console.WriteLine("Server certificate details: " + win32Cert.GetCertificateName());
            System.Console.WriteLine("Server certificate issuer details: " + win32Cert.GetIssuerName());
        }

        X509Certificate x509Cert = cert as X509Certificate;
        if (x509Cert != null)
        {
            System.Console.WriteLine("Server certificate details: " + x509Cert.GetCertificateName());
            System.Console.WriteLine("Server certificate issuer details: " + x509Cert.GetIssuerName());
        }

        return true;
    }

    static int Run(string[] args)
    {
        ParseCommandLine(args);

        // Locate path to certificates folder in distribution.
        string rootDir = DllPathResolver.FindDistributionRootDir();
        string certsDir = Path.Combine(rootDir, "certs");

        // Initialize RCFProto.
        RCFProto.Init();

        // Build a search request.
        SearchRequest request = SearchRequest.CreateBuilder()
            .SetQuery("something to search for")
            .SetResultPerPage(10)
            .SetPageNumber(0)
            .Build();

        // Call the server on each of its supported endpoints.
        List<Endpoint> endpoints = new List<Endpoint>();
        endpoints.Add(new TcpEndpoint(50001));
        endpoints.Add(new HttpEndpoint(50002));
        endpoints.Add(new Win32NamedPipeEndpoint("DemoServerPipe"));

        foreach (Endpoint endpoint in endpoints)
        {
            // Create channel.
            RcfProtoChannel channel = new RcfProtoChannel(endpoint);
            RcfProtoController rcfController = new RcfProtoController();
            SearchService.Stub searchService = new SearchService.Stub(channel);

            // Set certificate validation callback, for SSL.
            channel.SetCertificateValidationCallback(OnValidateCertificate);

            {
                // Synchronous remote call.
                searchService.Search(null, request, null);
                SearchResponse response = (SearchResponse)channel.GetResponse();
            }

            {
                // Asynchronous remote call.
                channel.SetAsynchronousRpcMode(true);

                Action<SearchResponse> done = delegate(SearchResponse response)
                {
                    OnRpcDone(searchService, rcfController, request, response);
                };
                searchService.Search(rcfController, request, done);

                while (gCallCompleted == false)
                {
                    System.Threading.Thread.Sleep(500);
                }
            }
        }

        {
            // Create TCP channel.
            RcfProtoChannel channel = new RcfProtoChannel(endpoints[0]);
            RcfProtoController rcfController = new RcfProtoController();
            SearchService.Stub searchService = new SearchService.Stub(channel);

            // Enable compression (requires zlib to be installed).
            //channel.SetEnableCompression(true);

            // Custom connection timeout (10s).
            channel.SetConnectTimeoutMs(10 * 1000);

            // Custom remote call timeout (60s).
            channel.SetRemoteCallTimeoutMs(60 * 1000);

            if (RCFProto.IsProBuild())
            {
                // Enable NTLM authentication and encryption.
                channel.SetTransportProtocol(TransportProtocol.Ntlm);

                // The channel will pick up the credentials of the user running the 
                // program. Alternatively, we can set the credentials explicitly:

                //channel.setUsername("MyDomain\\MyUsername");
                //channel.setPassword("MyPassword");

                searchService.Search(null, request, null);
                SearchResponse response = (SearchResponse)channel.GetResponse();
            }

            if (RCFProto.IsProBuild())
            {
                // Enable SSL, with custom certificate validation callback.
                channel.SetTransportProtocol(TransportProtocol.Ssl);
                channel.SetCertificateValidationCallback(OnValidateCertificate);

                searchService.Search(null, request, null);
                SearchResponse response = (SearchResponse)channel.GetResponse();

                // Enable SSL, with validation against Windows certificate root store. Requires Schannel.
                string certPath = Path.Combine(certsDir, "caCertA.p12");

                // Open CA certificate.
                PfxCertificate caCert = new PfxCertificate(certPath, "", "RCF CA A");

                // Add it to the root store of the local machine.
                caCert.AddToStore(Win32CertificateLocation.LocalMachine, Win32CertificateStore.Root);

                channel.SetEnableSchannelCertificateValidation("localhost");
                channel.SetSslImplementation(SslImplementation.Schannel);

                // Disconnect so SSL handshake takes place again.
                channel.Disconnect();

                searchService.Search(null, request, null);
                response = (SearchResponse)channel.GetResponse();
            }
        }

        return 0;
    }


    // Command line options for the automated test harness.
    static void ParseCommandLine(string[] args)
    {

        // Check for --delay option.
        int delayMs = 0;
        for (int i = 0; i < args.Length; ++i)
        {
            if (args[i] == "--delay")
            {
                delayMs = 1000;
                if (i + 1 < args.Length)
                {
                    int tempVal = Convert.ToInt32(args[i + 1]);
                    if (tempVal > 0)
                    {
                        delayMs = tempVal;
                        i++;
                    }
                }
            }
        }
        if (delayMs > 0)
        {
            System.Console.WriteLine("Delaying client: " + delayMs.ToString() + " ms.");
            System.Threading.Thread.Sleep(delayMs);
        }

        // Check for --shutdown option.
        bool shouldShutdownServer = false;
        for (int i = 0; i < args.Length; i++)
        {
            if (args[i] == "--shutdown")
            {
                shouldShutdownServer = true;
            }
        }

        if (shouldShutdownServer)
        {
            System.Console.WriteLine("Sending shutdown request to server.");
            RCFProto.Init();
            RcfProtoChannel channel = new RcfProtoChannel(new TcpEndpoint("127.0.0.1", 50001));
            RcfProtoController rcfController = new RcfProtoController();
            SearchService.Stub searchService = new SearchService.Stub(channel);
            ShutdownServerRequest shutdownRequest = ShutdownServerRequest.CreateBuilder().Build();
            searchService.ShutdownServer(null, shutdownRequest, null);

            // Give the server some time to shutdown.
            System.Threading.Thread.Sleep(1000);

            Environment.Exit(0);
        }
    }

}
