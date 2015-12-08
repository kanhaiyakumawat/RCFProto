
#include <iostream>
#include <fstream>
#include <RCFProto.hpp>
#include <google/protobuf/text_format.h>
#include "Demo.pb.h"

void parseCommandLine(int argc, char ** argv);
std::string getCertsPath();

using namespace google::protobuf;
using namespace RCF;


void printRequest(const google::protobuf::Message * request)
{
    std::cout << "*** Sending request ***" << std::endl;
    std::string strRequest;
    TextFormat::PrintToString(*request, &strRequest);
    std::cout << strRequest << std::endl;
}

void printResponse(const google::protobuf::Message * response)
{
    std::cout << "*** Received response ***" << std::endl;
    std::string strResponse;
    TextFormat::PrintToString(*response, &strResponse);
    std::cout << strResponse << std::endl;
}

bool gCallCompleted = false;

// Remote call completion handler.
void onCompletion(
    RcfProtoController *                            pController, 
    std::pair<SearchRequest *, SearchResponse *>    args)
{
    if (pController->Failed())
    {
        std::cout << "RPC error: " << pController->ErrorText() << std::endl;
    }
    else
    {
        SearchRequest * pRequest = args.first;
        SearchResponse * pResponse = args.second;
    }
    gCallCompleted = true;
}

// Certificate validation callback.
bool onValidateCertificate(RCF::Certificate * pCert)
{
    RCF::Win32Certificate * pWin32Cert = dynamic_cast<RCF::Win32Certificate *>(pCert);
    if (pWin32Cert)
    {
        std::cout << "Server certificate details: " << RCF::toAstring(pWin32Cert->getCertificateName()) << std::endl;
        std::cout << "Server certificate issuer details: " << RCF::toAstring(pWin32Cert->getIssuerName()) << std::endl;
    }

    RCF::X509Certificate * pX509Cert = dynamic_cast<RCF::X509Certificate *>(pCert);
    if (pX509Cert)
    {
        std::cout << "Server certificate details: " << pX509Cert->getCertificateName() << std::endl;
        std::cout << "Server certificate issuer details: " << pX509Cert->getIssuerName() << std::endl;
    }

    return true;
}

#ifdef BOOST_WINDOWS
bool gOnWindows = true;
#else
bool gOnWindows = false;
#endif

int main(int argc, char ** argv)
{
    try
    {

        bool isProBuild = RCF::isProBuild();

        parseCommandLine(argc, argv);

        // Locate path to certificates folder in distribution.
        std::string certsPath = getCertsPath();
        std::cout << "Certs path: " << certsPath << std::endl;

        // Initialize RCFProto.
        RCF::init();

        // Create request object.
        SearchRequest request;
        request.set_query("something to search for");
        request.set_result_per_page(10);
        request.set_page_number(0);
        request.set_corpus(SearchRequest_Corpus_NEWS);

        // Create response object.
        SearchResponse response;

        // Call the server on each of its supported endpoints.

        std::vector<RCF::EndpointPtr> endpoints;
        endpoints.push_back( RCF::EndpointPtr( new RCF::TcpEndpoint(50001) ) );
        endpoints.push_back( RCF::EndpointPtr( new RCF::HttpEndpoint(50002) ) );

        if (gOnWindows)
        {
            endpoints.push_back( RCF::EndpointPtr( new RCF::Win32NamedPipeEndpoint(RCF::toTstring("DemoServerPipe")) ) );
        }
        else
        {
            endpoints.push_back( RCF::EndpointPtr( new RCF::UnixLocalEndpoint("DemoServerPipe") ) );
        }
        
        for (std::size_t i=0; i<endpoints.size(); ++i)
        {
            RCF::Endpoint & endpoint = *endpoints[i];

            // Create channel.
            RcfProtoChannel channel(endpoint);
            SearchService::Stub stub(&channel);

            // Set certificate validation callback, for SSL.
            channel.setCertificateValidationCallback(onValidateCertificate);

            // Synchronous remote call.
            stub.Search(NULL, &request, &response, NULL);

            response.Clear();

            // Asynchronous remote call.
            gCallCompleted = false;
            RcfProtoController controller;
            Closure * pClosure = NewCallback(&onCompletion, &controller, std::make_pair(&request, &response));
            stub.Search(&controller, &request, &response, pClosure);
            while (!gCallCompleted) RCF::sleepMs(500);
        }

        // Create TCP channel.
        RcfProtoChannel channel(*endpoints[0]);
        SearchService::Stub stub(&channel);

        // Enable compression (requires zlib to be installed).
        //channel.setEnableCompression(true);

        // Custom connection timeout (10s).
        channel.setConnectTimeoutMs(10*1000);

        // Custom remote call timeout (60s).
        channel.setRemoteCallTimeoutMs(60*1000);

        // Enable NTLM authentication and encryption if we are on Windows.
        if (isProBuild && gOnWindows)
        {
            channel.setTransportProtocol(Tp_Ntlm);

            // The channel will pick up the credentials of the user running the 
            // program. Alternatively, we can set the credentials explicitly:

            //channel.setUsername("MyDomain\\MyUsername");
            //channel.setPassword("MyPassword");

            response.Clear();
            stub.Search(NULL, &request, &response, NULL);
        }

        if (!gOnWindows)
        {
            // Enable SSL, with custom certificate validation callback.
            channel.setTransportProtocol(Tp_Ssl);
            channel.setCertificateValidationCallback(onValidateCertificate);
            response.Clear();
            stub.Search(NULL, &request, &response, NULL);

            // Enable SSL, with certificate authority validation. Requires OpenSSL.
            std::string certPath = certsPath + "/caCertA.pem";
            RCF::CertificatePtr caCertPtr( new PemCertificate(certPath, "") );
            channel.setCaCertificate(caCertPtr);
            channel.setSslImplementation(Si_OpenSsl);
        
            // Disconnect so SSL handshake takes place again.
            channel.disconnect();

            response.Clear();
            stub.Search(NULL, &request, &response, NULL);
        }

        // Enable SSL, with validation against Windows certificate root store. Requires Schannel.
        if (isProBuild && gOnWindows)
        {
            std::string certPath = certsPath + "\\caCertA.p12";

            // Open CA certificate.
            PfxCertificate caCert(
                certPath, 
                RCF::toTstring(""),
                RCF::toTstring("RCF CA A"));

            // Add it to the root store of the local machine.
            caCert.addToStore(Cl_LocalMachine, Cs_Root);

            channel.setEnableSchannelCertificateValidation(RCF::toTstring("localhost"));
            channel.setSslImplementation(Si_Schannel);

            // Disconnect so SSL handshake takes place again.
            channel.disconnect();

            response.Clear();
            stub.Search(NULL, &request, &response, NULL);
        }
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

void parseCommandLine(int argc, char ** argv)
{
    int delayMs = 0;
    bool shutdownServer = false;

    for (int i=0; i<argc; ++i)
    {
        if ( std::string(argv[i]) == "--delay" )
        {
            delayMs = 1000;
            if (i+1 < argc)
            {
                int tempVal = atoi(argv[i+1]);
                if (tempVal)
                {
                    delayMs = tempVal;
                    ++i;
                }
            }
        }
        else if ( std::string(argv[i]) == "--shutdown" )
        {
            shutdownServer = true;
        }
    }

    if (shutdownServer)
    {
        std::cout << "Sending shutdown request to server." << std::endl;

        RCF::init();
        RcfProtoChannel         channel( RCF::TcpEndpoint(50001) );
        SearchService::Stub     stub(&channel);
        ShutdownServerRequest   shutdownRequest;
        ShutdownServerResponse  shutdownResponse;
        stub.ShutdownServer(NULL, &shutdownRequest, &shutdownResponse, NULL);

        // Give the server some time to shutdown.
        RCF::sleepMs(1000);

        exit(0);
    }

    if (delayMs)
    {
        std::cout << "Delaying client: " << delayMs << " ms." << std::endl;

        RCF::sleepMs(delayMs);
    }
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
