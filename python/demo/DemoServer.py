
import sys
import time
import threading
import os

# Fix up search paths for native DLL's.
import DllPathResolver
DllPathResolver.Resolve()

from deltavsoft.rcfproto import *
import Demo_pb2

evtShutdown = threading.Event()

class SearchServiceImpl(Demo_pb2.SearchService) :

    def PrintRequest(self, controller, request):
        print '************************';
        print '*** Received request ***';

        session = controller.GetSession();

        print 'Client username: '        + session.GetClientUsername()
        print 'Compression enabled: '    + str(session.GetEnableCompression())
        print 'Transport type: '         + str(session.GetTransportType())
        print 'Transport protocol: '     + str(session.GetTransportProtocol())

        print 'Request:';
        print str(request);

    def PrintResponse(self, response):
        print '*** Sending response ***'
        print str(response)
        print '************************'

    def Search(self, controller, request, done):

        self.PrintRequest(controller, request)

        # Build the response.
        response = Demo_pb2.SearchResponse()
        result = response.result.add()
        result.title = 'First result'
        result.url = 'http://acme.org'
        result.snippets.append('asdf')

        self.PrintResponse(response)

        # Send the response.
        done(response)

    def ShutdownServer(self, controller, request, done):

        self.PrintRequest(controller, request)

        evtShutdown.set()
        response = Demo_pb2.ShutdownServerResponse()

        self.PrintResponse(response)

        done(response)


# Which OS are we on?
onWindows = (os.name == 'nt')

# Locate path to certificates folder in distribution.
rootDir = DllPathResolver.FindDistributionRootDir()
certsDir = os.path.join(rootDir, 'certs')

# Initialize RCFProto.
init()

# Create server.
server = RcfProtoServer()

# Bind protobuf service.
svc = SearchServiceImpl()
server.BindService(svc)

# Add the endpoints that this server will support.
endpoints = [
    TcpEndpoint('127.0.0.1', 50001),
    HttpEndpoint('127.0.0.1', 50002)
    ]

if onWindows:
    endpoints.append( Win32NamedPipeEndpoint('DemoServerPipe') )
else:
    # Delete any previous instance of the local socket.
    if os.path.exists('DemoServerPipe'):
        os.remove('DemoServerPipe')
    endpoints.append( UnixLocalEndpoint('DemoServerPipe') )

for endpoint in endpoints:
    server.AddEndpoint(endpoint)

# By default, the server serves clients on a single thread. Here, we are
# configuring the server to use a thread pool with up to 10 threads.
threadPool = ThreadPool(1, 10);
threadPool.SetThreadName('RCFProto Server');
server.SetThreadPool(threadPool);

# Configure SSL certificate.
if onWindows:

    # Load certificate from PFX format.
    certPath = os.path.join(certsDir, 'certA.p12');
    cert = PfxCertificate(certPath, '', 'localhost');

    server.SetSslImplementation(Si_Schannel);
    server.SetCertificate(cert);

else:

    # Load certificate from OpenSSL PEM format.
    certPath = os.path.join(certsDir, 'certA.pem');
    cert = PemCertificate(certPath, '');

    server.SetSslImplementation(Si_OpenSsl);
    server.SetCertificate(cert);

# Start the server.
server.Start()

# Wait for shutdown.
evtShutdown.wait()

# Stop the server.
server.Stop()

# Deinitialize RCF.
deinit()
