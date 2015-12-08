
import java.io.File;
import java.util.*;

import com.google.protobuf.*;
import com.deltavsoft.rcfproto.*;

// Remote call completion handler.
class OnRpcDone implements RpcCallback<Proto.SearchResponse>
{
    public OnRpcDone(RcfProtoController controller)
    {
        mController = controller;
    }

    public void run(Proto.SearchResponse response)
    {
        if (mController.failed())
        {
            System.out.println("RPC error: " + mController.errorText());    
        }
        mFinished = true;
    }

    public RcfProtoController mController;
    public boolean mFinished = false;
}

// Certificate validation callback.
class OnValidateCertificate implements CertificateValidationCallback
{
    
    public boolean run(Certificate cert)
    {        
        if (cert instanceof Win32Certificate)
        {
            Win32Certificate win32Cert = (Win32Certificate)cert;
            System.out.println("Server certificate details: " + win32Cert.getCertificateName());
            System.out.println("Server certificate issuer details: " + win32Cert.getIssuerName());
        }

        
        if (cert instanceof X509Certificate)
        {
            X509Certificate x509Cert = (X509Certificate)cert;
            System.out.println("Server certificate details: " + x509Cert.getCertificateName());
            System.out.println("Server certificate issuer details: " + x509Cert.getIssuerName());
        }

        return true;
    }
}

public class DemoClient {

    public static void main(String[] args) {

        try
        {
            // Which OS are we on? 
            String runningOnOs = System.getProperty("os.name");
            boolean onWindows = false;
            if (runningOnOs.startsWith("Windows"))
            {
                onWindows = true;
            }

            // Configure DLL loading paths for RCFProto_Java_impl.dll / libRCFProto_Java_impl.so.
            DllPathResolver.resolve(args);

            parseCommandLine(args);
            
            // Locate path to certificates folder in distribution.
            String rootDir = DllPathResolver.findDistributionRootDir();
            File certsDir = new File(rootDir, "certs");
            
            // Initialize RCFProto.
            RCFProto.init();    

            // Build a search request.
            Proto.SearchRequest request = Proto.SearchRequest.newBuilder()
                .setQuery("something to search for")
                .setResultPerPage(10)
                .setPageNumber(0)
                .build();

            // Call the server on each of its supported endpoints.
            List<Endpoint> endpoints = new ArrayList<Endpoint>();
            endpoints.add(new TcpEndpoint(50001));
            endpoints.add(new HttpEndpoint(50002));
            
            if (onWindows)
            {
                endpoints.add(new Win32NamedPipeEndpoint("DemoServerPipe"));
            }
            else
            {
                endpoints.add(new UnixLocalEndpoint("DemoServerPipe"));
            }           

            for (Endpoint endpoint : endpoints)
            {
                // Create channel.
                RcfProtoChannel channel = new RcfProtoChannel(endpoint);
                RcfProtoController controller = new RcfProtoController();
                Proto.SearchService.Stub searchService = Proto.SearchService.newStub(channel);

                // Set certificate validation callback, for SSL.
                channel.setCertificateValidationCallback( new OnValidateCertificate() );

                {
                    // Synchronous remote call.
                    searchService.search(null, request, null);
                    Proto.SearchResponse response = (Proto.SearchResponse)channel.getResponse();
                }

                {
                    // Asynchronous remote call.
                    channel.setAsynchronousRpcMode(true);
                    OnRpcDone done = new OnRpcDone(controller); 
                    searchService.search(controller, request, done);
        
                    while (!done.mFinished)
                    {
                        Thread.sleep(500);
                    }
                }
            }
            
            {
                // Create TCP channel.
                RcfProtoChannel channel = new RcfProtoChannel(endpoints.get(0));
                Proto.SearchService.Stub searchService = Proto.SearchService.newStub(channel);

                // Enable compression (requires zlib to be installed).
                //channel.setEnableCompression(true);

                // Custom connection timeout (10s).
                channel.setConnectTimeoutMs(10 * 1000);

                // Custom remote call timeout (60s).
                channel.setRemoteCallTimeoutMs(60 * 1000);

                if (onWindows && RCFProto.isProBuild())
                {
                    // Enable NTLM authentication and encryption.
                    channel.setTransportProtocol(TransportProtocol.Ntlm);
    
                    // The channel will pick up the credentials of the user running the 
                    // program. Alternatively, we can set the credentials explicitly:
    
                    //channel.setUsername("MyDomain\\MyUsername");
                    //channel.setPassword("MyPassword");
    
                    searchService.search(null, request, null);
                    Proto.SearchResponse response = (Proto.SearchResponse)channel.getResponse();
                }

                if (!onWindows)
                {
                    // Enable SSL, with custom certificate validation callback.
                    channel.setTransportProtocol(TransportProtocol.Ssl);
                    channel.setCertificateValidationCallback( new OnValidateCertificate() );

                    searchService.search(null, request, null);
                    Proto.SearchResponse response = (Proto.SearchResponse)channel.getResponse();

                    // Enable SSL, with certificate authority validation. Requires OpenSSL.
                    File certPath = new File(certsDir, "caCertA.pem");                  
                    PemCertificate caCert = new PemCertificate(certPath.getAbsolutePath(), "");
                    channel.setCaCertificate(caCert);
                    channel.setSslImplementation(SslImplementation.OpenSsl);
                
                    // Disconnect so SSL handshake takes place again.
                    channel.disconnect();
                    
                    searchService.search(null, request, null);
                    response = (Proto.SearchResponse)channel.getResponse();
                }
                
                // Enable SSL, with validation against Windows certificate root store. Requires Schannel.
                if (onWindows && RCFProto.isProBuild())
                {
                    File certPath = new File(certsDir, "caCertA.p12");
    
                    // Open CA certificate.
                    PfxCertificate caCert = new PfxCertificate(certPath.getAbsolutePath(), "", "RCF CA A");
    
                    // Add it to the root store of the local machine.
                    caCert.addToStore(Win32CertificateLocation.LocalMachine, Win32CertificateStore.Root);
    
                    channel.setEnableSchannelCertificateValidation("localhost");
                    channel.setSslImplementation(SslImplementation.Schannel);
    
                    // Disconnect so SSL handshake takes place again.
                    channel.disconnect();
    
                    searchService.search(null, request, null);
                    Proto.SearchResponse response = (Proto.SearchResponse)channel.getResponse();
                }
            }
            
            System.exit(0);

        }
        catch(Exception e)
        {
            System.out.println("DemoClient exception:");
            System.out.println(e.getMessage());

            System.exit(1);
        }

    }
    
    // Command line options for the automated test harness.
    public static void parseCommandLine(String[] args) throws Exception, InterruptedException
    {
        // Check for --delay option.
        int delayMs = 0;
        for (int i = 0; i < args.length; ++i)
        {
            if (args[i] == "--delay")
            {
                delayMs = 1000;
                if (i + 1 < args.length)
                {
                    int tempVal = Integer.parseInt(args[i + 1]);
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
            System.out.println("Delaying client: " + Integer.toString(delayMs) + " ms.");
            java.lang.Thread.sleep(delayMs);
        }
        
        // Check for --shutdown option.
        boolean shouldShutdownServer = false;
        for (int i=0; i<args.length; i++)
        {
            if (args[i].equals("--shutdown"))
            {
                shouldShutdownServer = true;
                break;
            }
        }
                
        if (shouldShutdownServer)
        {
            System.out.println("Sending shutdown request to server.");
            RCFProto.init();                        
            RcfProtoChannel channel = new RcfProtoChannel( new TcpEndpoint("127.0.0.1", 50001) );
            Proto.SearchService.Stub searchService = Proto.SearchService.newStub(channel);
            Proto.ShutdownServerRequest shutdownRequest = Proto.ShutdownServerRequest.newBuilder().build();
            searchService.shutdownServer(null, shutdownRequest, null);

            // Give the server some time to shutdown.
            java.lang.Thread.sleep(delayMs);

            System.exit(0);
        }
    }

}
