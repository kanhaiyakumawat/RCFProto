
#include <iostream>
#include <fstream>
#include <RCFProto.hpp>
#include <google/protobuf/text_format.h>
#include "Demo.pb.h"

std::string getCertsPath();

using namespace google::protobuf;
using namespace RCF;

// SearchService implementation.
class SearchServiceImpl : public SearchService
{
private:

    void printRequest(RpcController* controller, const google::protobuf::Message * request)
    {
        std::cout << "************************" << std::endl;
        std::cout << "*** Received request ***" << std::endl;

        RcfProtoController * rcfController = static_cast<RcfProtoController *>(controller);
        RcfProtoSession * pSession = rcfController->getSession();

        std::cout << "Client username: "        << RCF::toAstring(pSession->getClientUsername())                    << std::endl;
        std::cout << "Compression enabled: "    << pSession->getEnableCompression()                                 << std::endl;
        std::cout << "Transport type: "         << RCF::getTransportTypeName(pSession->getTransportType())          << std::endl;
        std::cout << "Transport protocol: "     << RCF::getTransportProtocolName(pSession->getTransportProtocol())  << std::endl;

        std::string strRequest;
        TextFormat::PrintToString(*request, &strRequest);
        std::cout << "Request: " << std::endl;
        std::cout << strRequest << std::endl;
    }

    void printResponse(google::protobuf::Message * response)
    {
        std::cout << "*** Sending response ***" << std::endl;
        std::string strResponse;
        TextFormat::PrintToString(*response, &strResponse);
        std::cout << strResponse << std::endl;
        std::cout << "************************" << std::endl;
    }

public:

    void Search(
        RpcController *                 controller,
        const SearchRequest *           request,
        SearchResponse *                response,
        Closure *                       done)
    {
        printRequest(controller, request);

        // Fill in the response.
        SearchResponse_Result * result = response->add_result();
        result->set_title("First result");
        result->set_url("http://acme.org/");
        result->add_snippets("A snippet from acme.org.");

        result = response->add_result();
        result->set_title("Second result");
        result->set_url("http://acme.org/abc");
        result->add_snippets("Another snippet from acme.org.");

        printResponse(response);

        // We're done.
        done->Run();
    }

    static volatile bool gShutdownServer;

    void ShutdownServer(
        RpcController *                 controller,
        const ShutdownServerRequest *   request,
        ShutdownServerResponse *        response,
        Closure *                       done)
    {
        printRequest(controller, request);

        gShutdownServer = true;
        done->Run();
    }

};

volatile bool SearchServiceImpl::gShutdownServer = false;

#ifdef BOOST_WINDOWS
bool gOnWindows = true;
#else
bool gOnWindows = false;
#endif

int main(int argc, char ** argv)
{
    try
    {
        // Locate path to certificates folder in distribution.
        std::string certsPath = getCertsPath();
        std::cout << "Certs path: " << certsPath << std::endl;

        // Initialize RCFProto.
        RCF::init();

        // Create server.
        RcfProtoServer server;

        // Bind Protobuf service.
        SearchServiceImpl searchServiceImpl;
        server.bindService(searchServiceImpl);

        // Add the endpoints that this server will support.
        std::vector<RCF::EndpointPtr> endpoints;
        endpoints.push_back( RCF::EndpointPtr( new RCF::TcpEndpoint(50001) ) );
        endpoints.push_back( RCF::EndpointPtr( new RCF::HttpEndpoint(50002) ) );

        if (gOnWindows)
        {
            endpoints.push_back( RCF::EndpointPtr( new RCF::Win32NamedPipeEndpoint(RCF::toTstring("DemoServerPipe")) ) );
        }
        else
        {
            // Delete any previous instance of the local socket.
            if (std::ifstream("DemoServerPipe").good())
            {
                throw std::runtime_error("Could not remove previous instance of local socket \"DemoServerPipe\".");
            }
            int ret = remove("DemoServerPipe");
            
            endpoints.push_back( RCF::EndpointPtr( new RCF::UnixLocalEndpoint("DemoServerPipe") ) );
        }


        for (std::size_t i=0; i<endpoints.size(); ++i)
        {
            RCF::Endpoint & endpoint = *endpoints[i];
            server.addEndpoint(endpoint);
        }

        // By default, the server serves clients on a single thread. Here, we are 
        // configuring the server to use a thread pool with up to 10 threads.
        RCF::ThreadPoolPtr threadPoolPtr( new RCF::ThreadPool(1, 10) );
        threadPoolPtr->setThreadName("RCFProto Server");
        server.setThreadPool(threadPoolPtr);

        // Configure SSL certificate.

        if (gOnWindows)
        {
            // Load certificate from PFX format.
            std::string certPath = certsPath + "\\certA.p12";

            server.setSslImplementation(RCF::Si_Schannel);
            
            RCF::CertificatePtr certPtr( new RCF::PfxCertificate(
                certPath, 
                RCF::toTstring(""), 
                RCF::toTstring("localhost")) );

            server.setCertificate(certPtr);
        }
        else
        {
            // Load certificate from OpenSSL PEM format.
            std::string certPath = certsPath + "/certA.pem";

            server.setSslImplementation(RCF::Si_OpenSsl);

            RCF::CertificatePtr certPtr( new RCF::PemCertificate(
                certPath, 
                "") );

            server.setCertificate(certPtr);
        }

        // Start the server.
        server.start();

        // Wait for shutdown.
        while ( !SearchServiceImpl::gShutdownServer )
        {
            RCF::sleepMs(1000);
        }

        std::cout << "Server shutting down." << std::endl;
    }
    catch(const RCF::Exception & e)
    {
        std::cout << "RCF::Exception: " << e.getErrorString() << std::endl;
        return 1;
    }
    catch(const std::exception & e)
    {
        std::cout << "std::exception: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}

// Determine path to certificates folder in distribution.
std::string getCertsPath()
{
    std::string p = ".";
    std::size_t tries = 0;
    while (tries < 10)
    {
        std::string testDir = p + "/certs";
        std::string testPath = testDir + "/certA.pem";
        if (std::ifstream(testPath.c_str()).good())
        {
#ifdef BOOST_WINDOWS
            char buffer[1024] = {0};
            _fullpath(buffer, testDir.c_str(), 1024);
            return std::string(buffer);
#else
            char buffer[PATH_MAX] = {0};
            realpath(testDir.c_str(), buffer);
            return std::string(buffer);
#endif
        }
        p += "/..";
        ++tries;
    }
    return "";
}
