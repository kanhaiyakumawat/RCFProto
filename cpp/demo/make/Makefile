
all: DemoServer DemoClient libRCFProto.so

Demo.pb.cc: ../Demo.proto
	protoc ../Demo.proto --proto_path=.. --cpp_out=.

RCF.o: 
	g++ -fPIC -c ../../src/RCF/src/RCF/RCF.cpp -DRCF_BUILD_DLL -DRCF_USE_ZLIB -DRCF_USE_OPENSSL -I/home/user/Development/boost_1_49_0 -I../../src -I../../src/RCF/include

RCFProto.o: 
	g++ -fPIC -c ../../src/RCFProto.cpp -DRCF_BUILD_DLL -DRCF_USE_ZLIB -DRCF_USE_OPENSSL -I/home/user/Development/boost_1_49_0 -I../../src -I../../src/RCF/include

libRCFProto.so: RCFProto.o RCF.o
	g++ -shared -o libRCFProto.so RCFProto.o RCF.o -lpthread -lprotobuf -ldl 

DemoServer: ../DemoServer.cpp Demo.pb.cc libRCFProto.so
	g++ -oDemoServer ../DemoServer.cpp Demo.pb.cc -DRCF_USE_ZLIB -DRCF_USE_OPENSSL -I/home/user/Development/boost_1_49_0 -I. -I../../src -I../../src/RCF/include -lpthread -lprotobuf -ldl -lRCFProto -L.

DemoClient: ../DemoClient.cpp Demo.pb.cc libRCFProto.so
	g++ -oDemoClient ../DemoClient.cpp Demo.pb.cc -DRCF_USE_ZLIB -DRCF_USE_OPENSSL -I/home/user/Development/boost_1_49_0 -I. -I../../src -I../../src/RCF/include -lpthread -lprotobuf -ldl  -lRCFProto -L.
