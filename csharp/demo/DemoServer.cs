
using System;
using System.IO;
using System.Collections.Generic;
using System.Threading;

using Google.ProtocolBuffers;
using DeltaVSoft.RCFProto;
using ThreadPool = DeltaVSoft.RCFProto.ThreadPool;

// SearchService implementation.
public class SearchServiceImpl : SearchService
{
    private void PrintRequest(
        Google.ProtocolBuffers.IRpcController controller, 
        Google.ProtocolBuffers.IMessage request)
    {
        System.Console.WriteLine("************************");
        System.Console.WriteLine("*** Received request ***");

        RcfProtoController rcfController = (RcfProtoController)controller;
        RcfProtoSession session = rcfController.GetSession();

        System.Console.WriteLine("Client username: "        + session.GetClientUsername());
        System.Console.WriteLine("Compression enabled: "    + session.GetEnableCompression());
        System.Console.WriteLine("Transport type: "         + session.GetTransportType());
        System.Console.WriteLine("Transport protocol: "     + session.GetTransportProtocol());

        string strRequest = request.ToString();
        System.Console.WriteLine("Request:");
        System.Console.WriteLine(strRequest);
    }

    private void PrintResponse(Google.ProtocolBuffers.IMessage response)
    {
        System.Console.WriteLine("*** Sending response ***");
        string strResponse = response.ToString();
        System.Console.WriteLine(strResponse);
        System.Console.WriteLine("************************");
    }

    public override void Search(
        Google.ProtocolBuffers.IRpcController controller,
        SearchRequest request,
        System.Action<SearchResponse> done)
    {
        PrintRequest(controller, request);

        // Build the response.
        SearchResponse.Types.Result result = SearchResponse.Types.Result.CreateBuilder()
            .SetUrl("http://someurl.com")
            .Build();

        SearchResponse response = SearchResponse.CreateBuilder()
            .AddResult(result)
            .Build();

        PrintResponse(response);

        // Send the response.
        done(response);
    }

    public static AutoResetEvent ShutdownEvent = new AutoResetEvent(false);

    public override void ShutdownServer(
        Google.ProtocolBuffers.IRpcController controller,
        ShutdownServerRequest request,
        System.Action<ShutdownServerResponse> done)
    {
        PrintRequest(controller, request);

        ShutdownEvent.Set();
        ShutdownServerResponse response = ShutdownServerResponse.CreateBuilder().Build();

        PrintResponse(response);

        done(response);
    }

}

class Program
{
    static int Main(string[] args)
    {
        try
        {
            // Configure DLL loading paths for RCFProto_NET.dll and RCFProto_NET_impl.dll.
            DllPathResolver.Resolve(args);

            return Run();
        }
        catch (Exception e)
        {
            System.Console.WriteLine(e.Message);
        }

        return 1;
    }

    static int Run()
    {
        // Locate path to certificates folder in distribution.
        string rootDir = DllPathResolver.FindDistributionRootDir();
        string certsDir = Path.Combine(rootDir, "certs");

        // Initialize RCF.
        RCFProto.Init();

        // Create server.
        RcfProtoServer server = new RcfProtoServer();

        // Bind Protobuf service.
        SearchServiceImpl myService = new SearchServiceImpl();
        server.BindService(myService);

        // Add the endpoints that this server will support.
        List<Endpoint> endpoints = new List<Endpoint>();
        endpoints.Add(new TcpEndpoint(50001));
        endpoints.Add(new HttpEndpoint(50002));
        endpoints.Add(new Win32NamedPipeEndpoint("DemoServerPipe"));

        foreach(Endpoint endpoint in endpoints)
        {
            server.AddEndpoint(endpoint);
        }

        // By default, the server serves clients on a single thread. Here, we are 
        // configuring the server to use a thread pool with up to 10 threads.
        ThreadPool threadPool = new ThreadPool(1, 10);
        threadPool.SetThreadName("RCFProto Server");
        server.SetThreadPool(threadPool);

        // Configure SSL certificate.

        // Load certificate from PFX format.
        string certPath = Path.Combine(certsDir, "certA.p12");
        Certificate cert = new PfxCertificate(certPath, "", "localhost");

        server.SetCertificate(cert);
        server.SetSslImplementation(SslImplementation.Schannel);

        // Start the server.
        server.Start();

        // Wait for shutdown.
        SearchServiceImpl.ShutdownEvent.WaitOne();
        System.Console.WriteLine("Shutting down server.");

        // Stop server.
        server.Stop();

        return 0;
    }
}
