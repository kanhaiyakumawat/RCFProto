
import java.io.File;
import java.util.*;

import com.google.protobuf.*;

import com.deltavsoft.rcfproto.*;

class SearchServiceImpl extends Proto.SearchService
{
    private void printRequest(
        com.google.protobuf.RpcController controller, 
        com.google.protobuf.Message request)
    {
        System.out.println("************************");
        System.out.println("*** Received request ***");

        RcfProtoController rcfController = (RcfProtoController)controller;
        RcfProtoSession session = rcfController.getSession();

        System.out.println("Client username: "        + session.getClientUsername());
        System.out.println("Compression enabled: "    + session.getEnableCompression());
        System.out.println("Transport type: "         + session.getTransportType());
        System.out.println("Transport protocol: "     + session.getTransportProtocol());

        String strRequest = request.toString();
        System.out.println("Request:");
        System.out.println(strRequest);

    }
    
    private void printResponse(com.google.protobuf.Message response)
    {
        System.out.println("*** Sending response ***");
        String strResponse = response.toString();
        System.out.println(strResponse);
        System.out.println("************************");     
    }
    
    public void search(
        com.google.protobuf.RpcController controller,
        Proto.SearchRequest request,
        com.google.protobuf.RpcCallback<Proto.SearchResponse> done)
    {       
        printRequest(controller, request);      

        // Build the response
        Proto.SearchResponse.Result result = Proto.SearchResponse.Result.newBuilder()
            .setUrl("http://someurl.com")
            .build();

        Proto.SearchResponse response = Proto.SearchResponse.newBuilder()
            .addResult(result)
            .build();
        
        printResponse(response);
        
        // Send the response.
        done.run(response);
    }


    public static boolean ShouldShutdown = false;

    public void shutdownServer(
        com.google.protobuf.RpcController controller,
        Proto.ShutdownServerRequest request,
        com.google.protobuf.RpcCallback<Proto.ShutdownServerResponse> done)
    {
        printRequest(controller, request);

        ShouldShutdown = true;
        Proto.ShutdownServerResponse response = Proto.ShutdownServerResponse.newBuilder().build();
        
        printResponse(response);
        
        done.run(response);
    }
}

public class DemoServer {

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
            
            // Locate path to certificates folder in distribution.
            String rootDir = DllPathResolver.findDistributionRootDir();
            File certsDir = new File(rootDir, "certs");

            // Initialize RCFProto.
            RCFProto.init();
            
            // Create server.
            RcfProtoServer server = new RcfProtoServer();

            // Bind Protobuf service.
            SearchServiceImpl myService = new SearchServiceImpl();
            server.bindService(myService);

            // Add the endpoints that this server will support.
            List<Endpoint> endpoints = new ArrayList<Endpoint>();
            endpoints.add(new TcpEndpoint(50001));
            endpoints.add(new HttpEndpoint(50002));
            
            if (onWindows)
            {
                endpoints.add(new Win32NamedPipeEndpoint("DemoServerPipe"));
            }
            else
            {
                // Delete any previous instance of the local socket.
                File file = new File("DemoServerPipe");
                if (file.exists())
                {
                    file.delete();
                }
                endpoints.add(new UnixLocalEndpoint("DemoServerPipe"));
            }           

            for (Endpoint endpoint : endpoints)
            {
                server.addEndpoint(endpoint);               
            }

            // By default, the server serves clients on a single thread. Here, we are 
            // configuring the server to use a thread pool with up to 10 threads.
            ThreadPool threadPool = new ThreadPool(1, 10);
            threadPool.setThreadName("RCFProto Server");
            server.setThreadPool(threadPool);

            // Configure SSL certificate.

            if (onWindows)
            {
                // Load certificate from PFX format.
                File certPath = new File(certsDir, "certA.p12");
                Certificate cert = new PfxCertificate(certPath.getAbsolutePath(), "", "localhost");
    
                server.setCertificate(cert);
                server.setSslImplementation(SslImplementation.Schannel);
            }
            else
            {
                // Load certificate from OpenSSL PEM format.
                File certPath = new File(certsDir, "certA.pem");
                Certificate cert = new PemCertificate(certPath.getAbsolutePath(), "");

                server.setCertificate(cert);
                server.setSslImplementation(SslImplementation.OpenSsl);             
            }

            // Start the server.
            server.start();

            // Wait for shutdown.
            while (!SearchServiceImpl.ShouldShutdown)
            {
                Thread.sleep(1000);
            }
            System.out.println("Shutting down server.");

            // Stop server.
            server.stop();

            // Deinitialize RCF.
            RCFProto.deinit();
        }
        catch(Exception e)
        {
            System.out.println("DemoServer exception:");
            System.out.println(e.getMessage());
            System.exit(1);
        }

        System.exit(0);

    }

}
