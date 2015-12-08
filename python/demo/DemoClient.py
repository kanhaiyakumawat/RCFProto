
import sys
import time
import threading
import os

# Fix up search paths for native DLL's.
import DllPathResolver
DllPathResolver.Resolve()

from deltavsoft.rcfproto import *
import Demo_pb2

# Command line options for automated testing.

# Check for --delay option.
if '--delay' in sys.argv:
    delayMs = 1000
    print 'Delaying client: ' + str(delayMs) + ' ms.'
    delayS = delayMs/1000.0
    time.sleep(delayS)

# Check for --shutdown option.
if '--shutdown' in sys.argv:
    print '*** Sending shutdown request to server. ***'
    init()
    tcpEndpoint     = TcpEndpoint("127.0.0.1", 50001)
    channel         = RcfProtoChannel(tcpEndpoint)
    searchService   = Demo_pb2.SearchService_Stub(channel)
    request         = Demo_pb2.ShutdownServerRequest()
    searchService.ShutdownServer(None, request, None)

    # Give the server some time to shutdown.
    time.sleep(1)

    sys.exit(0)

evtCompleted = threading.Event()

# Remote call completion handler.
def OnRpcDone(controller, response):
    if controller.Failed():
        print "RPC error: " + controller.ErrorText()
    evtCompleted.set()

# Certificate validation callback.
def OnValidateCertificate(cert):
    print "Server certificate details: " + cert.GetCertificateName()
    print "Server certificate issuer details: " + cert.GetIssuerName()
    return True

# Which OS are we on?
onWindows = (os.name == 'nt')

# Locate path to certificates folder in distribution.
rootDir = DllPathResolver.FindDistributionRootDir()
certsDir = os.path.join(rootDir, 'certs')

# Initialize RCFProto.
init()

# Build a search request.
request = Demo_pb2.SearchRequest()
request.query = 'Something to search for'
request.page_number = 1
request.result_per_page = 15

# Call the server on each of its supported endpoints.
endpoints = [
    TcpEndpoint('127.0.0.1', 50001),
    HttpEndpoint('127.0.0.1', 50002)
    ]

if onWindows:
    endpoints.append( Win32NamedPipeEndpoint('DemoServerPipe') )
else:
    endpoints.append( UnixLocalEndpoint('DemoServerPipe') )

for endpoint in endpoints:

    # Create channel.
    channel         = RcfProtoChannel(endpoint)
    controller      = RcfProtoController()
    searchService   = Demo_pb2.SearchService_Stub(channel)

    # Set certificate validation callback, for SSL.
    channel.SetCertificateValidationCallback(OnValidateCertificate);

    # Synchronous RPC.
    searchService.Search(None, request, None)
    response = channel.GetResponse();

    # Asynchronous RPC.
    channel.SetAsynchronousRpcMode(True)
    evtCompleted.clear()
    searchService.Search(controller, request, lambda response: OnRpcDone(controller, response))
    evtCompleted.wait()


# Create TCP channel.
channel         = RcfProtoChannel(endpoints[0])
controller      = RcfProtoController()
searchService   = Demo_pb2.SearchService_Stub(channel)

# Enable compression (requires zlib to be installed).
#channel.SetEnableCompression(true);

# Custom connection timeout (10s).
channel.SetConnectTimeoutMs(10 * 1000);

# Custom remote call timeout (60s).
channel.SetRemoteCallTimeoutMs(60 * 1000);

if onWindows and isProBuild():
    # Enable NTLM authentication and encryption.
    channel.SetTransportProtocol(Tp_Ntlm);

    # The channel will pick up the credentials of the user running the
    # program. Alternatively, we can set the credentials explicitly:

    #channel.setUsername("MyDomain\\MyUsername");
    #channel.setPassword("MyPassword");

    searchService.Search(None, request, None);
    response = channel.GetResponse();

if not onWindows:

    # Enable SSL, with custom certificate validation callback.
    channel.SetTransportProtocol(Tp_Ssl);
    channel.SetCertificateValidationCallback(OnValidateCertificate);

    searchService.Search(None, request, None);
    response = channel.GetResponse();

    # Enable SSL, with certificate authority validation. Requires OpenSSL.
    certPath = os.path.join(certsDir, "caCertA.pem");
    caCert = PemCertificate(certPath, "");
    channel.SetCaCertificate(caCert);
    channel.SetSslImplementation(Si_OpenSsl);

    # Disconnect so SSL handshake takes place again.
    channel.Disconnect();

    searchService.Search(None, request, None);
    response = channel.GetResponse()

# Enable SSL, with validation against Windows certificate root store. Requires Schannel.
if onWindows and isProBuild():
    certPath = os.path.join(certsDir, "caCertA.p12");

    # Open CA certificate.
    caCert = PfxCertificate(certPath, "", "RCF CA A");

    # Add it to the root store of the local machine.
    caCert.AddToStore(Cl_LocalMachine, Cs_Root);

    channel.SetEnableSchannelCertificateValidation("localhost");
    channel.SetSslImplementation(Si_Schannel);

    # Disconnect so SSL handshake takes place again.
    channel.Disconnect();

    searchService.Search(None, request, None);
    response = channel.GetResponse();

sys.exit(0)

