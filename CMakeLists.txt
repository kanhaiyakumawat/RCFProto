
################################################################################
### RCFProto command line build
################################################################################

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

CMAKE_POLICY(SET CMP0012 OLD)

################################################################################
# Configuration

# CMAKE_BUILD_TYPE is a bit special, it is defined as a cache variable by cmake itself.
# It turns out we can set its  default value, but we have to do so before the PROJECT() command.

IF(DEFINED CMAKE_BUILD_TYPE)
   SET(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "Choose the build type, options are: Debug Release.")
ELSE()
	# Default build should be Release.
   SET(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the build type, options are: Debug Release.")
ENDIF()

MESSAGE("CMAKE_BUILD_TYPE: " ${CMAKE_BUILD_TYPE})

PROJECT( RCFProto )

SET(ARCH x86)
IF(CMAKE_SIZEOF_VOID_P EQUAL 8)
  SET(ARCH x64)
ENDIF()

SET(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}) 
SET(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}) 
SET(RCFPROTO_ROOT ${CMAKE_SOURCE_DIR} )

# Find Boost.

FIND_PACKAGE(Boost)
IF(NOT Boost_FOUND)

    MESSAGE("Error: unable to find Boost library. Boost library is required for this build.")
	MESSAGE("If the Boost library is installed in a custom location, please set the cmake variables BOOST_INCLUDEDIR appropriately.")
	FORCE_CMAKE_ERROR()

ENDIF()

# Find RCF.

# In dev environments, RCF source is located in ../RCF.
# In the distribution, RCF source is located in cpp/src/RCF.
SET(RCF_ROOT ${RCFPROTO_ROOT}/cpp/src/RCF)
IF(NOT EXISTS ${RCF_ROOT})
SET(RCF_ROOT ${RCFPROTO_ROOT}/../RCF)
ENDIF()

MESSAGE("Using RCF source from directory: " ${RCF_ROOT} )

# Find Protobuf C++ lib.

FIND_PACKAGE(Protobuf)
IF( NOT PROTOBUF_FOUND )

    MESSAGE("Error: unable to find Protocol Buffers library. Protocol Buffers are required for this build.")
	MESSAGE("If the Protocol Buffers library is installed in a custom location, please set the cmake variables PROTOBUF_LIBRARY, PROTOBUF_LIBRARY_DEBUG and PROTOBUF_INCLUDE_DIR appropriately.")
	FORCE_CMAKE_ERROR()

ENDIF()

# Find OpenSSL and zlib.

# On Unix platforms, locate system-specific zlib and openssl headers.
IF (CMAKE_GENERATOR MATCHES "Unix")

	FIND_PACKAGE(ZLIB)
	IF ( ZLIB_FOUND )
		SET(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIR})
	ELSE()

		MESSAGE("zlib was not found. Building RCFProto without zlib.")
		MESSAGE("If zlib is installed in a custom location, please set the cmake variable ZLIB_INCLUDE_DIR appropriately.")

	ENDIF()

	FIND_PACKAGE(OpenSSL)
	IF ( OPENSSL_FOUND )
		SET(OPENSSL_INCLUDE_DIR ${OPENSSL_INCLUDE_DIR})
	ELSE()

		MESSAGE("OpenSSL was not found. Building RCFProto without OpenSSL.")
		MESSAGE("If OpenSSL is installed in a custom location, please set the cmake variable OPENSSL_INCLUDE_DIR appropriately .")

	ENDIF()

ENDIF()

# On Windows platforms, pass in zlib and openssl paths directly.
IF (CMAKE_GENERATOR MATCHES "NMake")

	IF (NOT ZLIB_INCLUDE_DIR)
		MESSAGE("zlib was not found. Building RCFProto without zlib.")
		MESSAGE("If zlib is installed in a custom location, please set the cmake variable ZLIB_INCLUDE_DIR appropriately.")
	ENDIF (NOT ZLIB_INCLUDE_DIR)

	IF (NOT OPENSSL_INCLUDE_DIR)
		MESSAGE("OpenSSL was not found. Building RCFProto without OpenSSL.")
		MESSAGE("If OpenSSL is installed in a custom location, please set the cmake variable OPENSSL_INCLUDE_DIR appropriately .")
	ENDIF (NOT OPENSSL_INCLUDE_DIR)

ENDIF (CMAKE_GENERATOR MATCHES "NMake")

# Find Python.

FIND_PACKAGE(PythonLibs)
IF(NOT PYTHONLIBS_FOUND)

	MESSAGE("Python was not found. Building RCFProto without Python support.")
	MESSAGE("If Python is installed in a custom location, please set the cmake variables PYTHON_LIBRARIES and PYTHON_INCLUDE_DIRS appropriately.")

ENDIF()

# Find Java.

# cmake doesn't do a very good job of finding Java, so we've customized it a bit.
IF (CMAKE_GENERATOR MATCHES "NMake")

	# On Windows, find JNI first, and then use that to determine where Java is.
	
	FIND_PACKAGE(JNI)

	# Determine Java paths from JNI headers. That way we get the Java installation
	# that matches with the JNI headers, rather than the first Java installation
	# that cmake finds. This is important when both x86 and x64 Java is installed.

	IF (JNI_FOUND)
		LIST(GET JNI_INCLUDE_DIRS 0 JAVA_INCLUDE)
		SET( Java_JAVAC_EXECUTABLE ${JAVA_INCLUDE}/../bin/javac.exe)
		SET( Java_JAVA_EXECUTABLE ${JAVA_INCLUDE}/../bin/java.exe)
		SET( Java_JAR_EXECUTABLE ${JAVA_INCLUDE}/../bin/jar.exe)		
	ENDIF()

ELSE()

	# On Unix, use cmake to find java, and then use that to find JNI.
	FIND_PACKAGE(Java)

	IF(JAVA_FOUND)

		# Set JAVA_HOME env var, if it isn't already set. This will help cmake find
		# JNI. Without it, cmake fill fail to find JNI on Ubuntu 12.
		IF( NOT ENV{JAVA_HOME} )
			FIND_FILE(_JAVA_LOC NAMES java PATHS ENV PATH)
			GET_FILENAME_COMPONENT(_JAVA_LOC "${_JAVA_LOC}" REALPATH)
			GET_FILENAME_COMPONENT(_JAVA_HOME "${_JAVA_LOC}/../../.." ABSOLUTE)	
			MESSAGE("JAVA_HOME environment variable is not set. Setting JAVA_HOME to" ${_JAVA_HOME} " , to assist cmake in finding JNI headers." )
			SET(ENV{JAVA_HOME} ${_JAVA_HOME})
		ENDIF()

		FIND_PACKAGE(JNI)

	ELSE()

		MESSAGE("JDK was not found. Building RCFProto without Java support.")
		MESSAGE("If JDK is installed in a custom location, please set the environment variable JAVA_HOME.")

	ENDIF() 

ENDIF()

IF(NOT JNI_FOUND)

	MESSAGE("JNI was not found. Building RCFProto without Java support.")
	MESSAGE("If JNI is installed in a custom location, please set the cmake variable JNI_INCLUDE_DIRS.")

ENDIF()

# cmake does not have an out-of-the-box option for finding the Protocol Buffer 
# Java bindings, so we have to do it ourselves.

IF(JNI_FOUND)
	IF(NOT PROTOBUF_JAVA_CLASS_PATH)

		MESSAGE("Searching for Protocol Buffers Java bindings.")
		SET( 
			SEARCH_PATHS
			/usr/share/java/protobuf.jar
			/usr/share/java/protobuf-java.jar )

		FOREACH(p ${SEARCH_PATHS})
			MESSAGE("Trying: " ${p})
			IF( EXISTS ${p} )
				MESSAGE("Found Protocol Buffers Java bindings: " ${p})
				SET(PROTOBUF_JAVA_CLASS_PATH ${p})
				BREAK()
			ENDIF()
		ENDFOREACH(p)

		IF( NOT PROTOBUF_JAVA_CLASS_PATH )
			MESSAGE("Could not find Protocol Buffers Java bindings. To specify location explicitly, set the PROTOBUF_JAVA_CLASS_PATH variable.")
		ENDIF()
		
	ENDIF()
ENDIF()


MESSAGE("************************************************")
MESSAGE("*** RCFProto build: Third party dependency summary ***")

MESSAGE("RCF include path: " ${RCF_ROOT}/include )
MESSAGE("Boost include path: " ${Boost_INCLUDE_DIRS} )

MESSAGE("Protobuf include path: " ${PROTOBUF_INCLUDE_DIRS})
MESSAGE("Protobuf libs: " ${PROTOBUF_LIBRARIES})	
MESSAGE("Protobuf debug lib: " ${PROTOBUF_LIBRARY_DEBUG})	
MESSAGE("Protobuf Java class path: " ${PROTOBUF_JAVA_CLASS_PATH} )

IF( JNI_FOUND )
	MESSAGE("JNI include paths: " ${JNI_INCLUDE_DIRS})
	MESSAGE( "Java compiler: " ${Java_JAVAC_EXECUTABLE} )
	MESSAGE( "Java runtime: " ${Java_JAVA_EXECUTABLE} )
	MESSAGE( "Java archiver: " ${Java_JAR_EXECUTABLE} )
ENDIF()

IF(PYTHONLIBS_FOUND)
	MESSAGE("Python include paths: " ${PYTHON_INCLUDE_DIRS})
	MESSAGE("Python libs: " ${PYTHON_LIBRARIES})
ENDIF()

IF( ZLIB_INCLUDE_DIR )
	MESSAGE("ZLIB include path: " ${ZLIB_INCLUDE_DIR})
ENDIF()

IF( OPENSSL_INCLUDE_DIR )
	MESSAGE("OpenSSL include path: " ${OPENSSL_INCLUDE_DIR})
ENDIF()

MESSAGE("************************************************")

################################################################################
# Some pseudo targets.

# build target
ADD_LIBRARY(
	build
	cpp/src/Dummy.cpp)

# test target
ADD_LIBRARY(
	test
	#EXCLUDE_FROM_ALL
	cpp/src/Dummy.cpp)

# demo target
ADD_LIBRARY(
	demo
	#EXCLUDE_FROM_ALL
	cpp/src/Dummy.cpp)

# Default build should not run tests or demos.
SET_TARGET_PROPERTIES(
	test 
	demo
	PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1 )

# Need async commands in order to run demo clients against demo servers.
# Windows and Unix use different syntax to run async commands ("start /b <command>" , vs "<command> &").
IF(CMAKE_GENERATOR MATCHES "NMake")

	SET(RUN_ASYNC_PRE start /b \"\" )
	SET(RUN_ASYNC_POST)

ELSE()

	SET(RUN_ASYNC_PRE)
	SET(RUN_ASYNC_POST &)

ENDIF()

################################################################################
# Start building.

# Configure defines.
ADD_DEFINITIONS(
    -DBOOST_ALL_NO_LIB
    -DWIN32_LEAN_AND_MEAN
    -DRCF_FEATURE_IPV6=1
    -DRCF_FEATURE_FILETRANSFER=0
	-DRCF_FEATURE_PUBSUB=0
	-DRCF_FEATURE_UDP=0
	-DRCF_FEATURE_LEGACY=0
	-DRCF_FEATURE_SF=1
	-DRCF_FEATURE_BOOST_SERIALIZATION=0 )

# For Windows, do a Unicode build.
IF(CMAKE_GENERATOR MATCHES "NMake")
	ADD_DEFINITIONS(
		-DUNICODE
		-D_UNICODE )
ENDIF()

# Do we have zlib.
IF(ZLIB_INCLUDE_DIR)
	ADD_DEFINITIONS(-DRCF_FEATURE_ZLIB=1)
	INCLUDE_DIRECTORIES( ${ZLIB_INCLUDE_DIR} )
ENDIF()

# Do we have OpenSSL.
IF(OPENSSL_INCLUDE_DIR)
	ADD_DEFINITIONS(-DRCF_FEATURE_OPENSSL=1)
	INCLUDE_DIRECTORIES( ${OPENSSL_INCLUDE_DIR} )
ENDIF()

# 64 bit msvc builds need /bigobj flag.
IF(CMAKE_GENERATOR MATCHES "NMake")
	IF(${ARCH} STREQUAL x64)
		SET( CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /bigobj" )
		SET( CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /bigobj" )
	ENDIF()
ENDIF()
    
# Configure include paths.
INCLUDE_DIRECTORIES(
	${RCF_ROOT}/include
	${RCFPROTO_ROOT}/cpp/src
    ${Boost_INCLUDE_DIRS}
    ${PROTOBUF_INCLUDE_DIRS} )

# Standard or professional build.

IF (ARCH STREQUAL x86)
	SET(CONF_NAME x86)
ELSE()
	SET(CONF_NAME x64)
ENDIF()

IF(RCF_PRO EQUAL 0 )
	ADD_DEFINITIONS(-DRCF_PRO=0)
	IF (${ARCH} STREQUAL x86)
		SET(CONF_NAME x86-std)
	ELSE()
		SET(CONF_NAME x64-std)
	ENDIF()
ENDIF()

IF(JNI_FOUND)
	INCLUDE_DIRECTORIES( ${JNI_INCLUDE_DIRS} )
ENDIF()

# Configure linker input
SET(RCFPROTO_LINKER_INPUT)

# Decide which protobuf C++ lib to link to (debug or release).
IF (CMAKE_BUILD_TYPE)
	
	IF (${CMAKE_BUILD_TYPE} STREQUAL Release)
		SET(RCFPROTO_LINKER_INPUT ${RCFPROTO_LINKER_INPUT} ${PROTOBUF_LIBRARIES} )
	ELSE (${CMAKE_BUILD_TYPE} STREQUAL Release)
		IF(PROTOBUF_LIBRARY_DEBUG)
			SET(RCFPROTO_LINKER_INPUT ${RCFPROTO_LINKER_INPUT} ${PROTOBUF_LIBRARY_DEBUG} )
		ELSE()
			SET(RCFPROTO_LINKER_INPUT ${RCFPROTO_LINKER_INPUT} ${PROTOBUF_LIBRARIES} )
		ENDIF()
	ENDIF()

ELSE (CMAKE_BUILD_TYPE)

	SET(RCFPROTO_LINKER_INPUT ${RCFPROTO_LINKER_INPUT} ${PROTOBUF_LIBRARIES} )

ENDIF (CMAKE_BUILD_TYPE)

# Some extra libs for non-Windows builds.
IF(NOT CMAKE_GENERATOR MATCHES "NMake")
	SET(RCFPROTO_LINKER_INPUT ${RCFPROTO_LINKER_INPUT} pthread dl) 
ENDIF()


# Disable some warnings.
# warning C4275: non dll-interface class '' used as base for dll-interface class ''
# warning C4251: '' : class '' needs to have dll-interface to be used by clients of class ''
IF(MSVC)
	ADD_DEFINITIONS(/wd4275 /wd4251)
ENDIF()

# With gcc, need -fPIC for static libs that are subsequently linked into DLLs.
IF(NOT CMAKE_GENERATOR MATCHES "NMake")
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
ENDIF()

# Build RCF.
ADD_LIBRARY(
	RCF
    STATIC
	${RCF_ROOT}/src/RCF/RCF.cpp )

# With gcc, need -fPIC for static libs that are subsequently linked into DLLs.
IF(NOT CMAKE_GENERATOR MATCHES "NMake")
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
ENDIF()

# Build RCFProto.
ADD_LIBRARY(
    RCFProto
    STATIC
    cpp/src/RCFProto.cpp )

TARGET_LINK_LIBRARIES(RCFProto RCF ${RCFPROTO_LINKER_INPUT})

ADD_CUSTOM_COMMAND(
	TARGET					RCFProto
	POST_BUILD
	COMMAND					${CMAKE_COMMAND} -E make_directory							${RCFPROTO_ROOT}/cpp/bin
	COMMAND					${CMAKE_COMMAND} -E copy ${PROTOBUF_PROTOC_EXECUTABLE}		${RCFPROTO_ROOT}/cpp/bin
	WORKING_DIRECTORY		${LIBRARY_OUTPUT_PATH} )

ADD_DEPENDENCIES(build RCFProto)

# Build RCFProto C# native DLL.
IF(MSVC)

	ADD_LIBRARY(
		RCFProto_NET_impl
		SHARED
		cpp/src/swig/RCFProto_NET_impl.cpp
		cpp/src/RCFProto_NET_impl.rc
		)
    
	TARGET_LINK_LIBRARIES(RCFProto_NET_impl RCFProto RCF ${RCFPROTO_LINKER_INPUT} )

	ADD_CUSTOM_COMMAND(
		TARGET					RCFProto_NET_impl
		POST_BUILD
		COMMAND					${CMAKE_COMMAND} -E make_directory												${RCFPROTO_ROOT}/csharp/bin/${CONF_NAME}
		COMMAND					${CMAKE_COMMAND} -E copy RCFProto_NET_impl.dll									${RCFPROTO_ROOT}/csharp/bin/${CONF_NAME}
		COMMAND					${CMAKE_COMMAND} -E copy ${PROTOBUF_PROTOC_EXECUTABLE}							${RCFPROTO_ROOT}/csharp/bin
		COMMAND					${CMAKE_COMMAND} -E copy ${PROTOBUF_PROTOGEN_EXECUTABLE}						${RCFPROTO_ROOT}/csharp/bin
		COMMAND					${CMAKE_COMMAND} -E copy ${PROTOBUF_NET_DLL_PATH}/Google.ProtocolBuffers.dll	${RCFPROTO_ROOT}/csharp/bin
		WORKING_DIRECTORY		${LIBRARY_OUTPUT_PATH} )

	ADD_DEPENDENCIES(build RCFProto_NET_impl)

ENDIF()

# Build RCFProto Java native DLL.
IF( JNI_FOUND )

	ADD_LIBRARY(
		RCFProto_Java_impl
		SHARED
		cpp/src/swig/RCFProto_Java_impl.cpp
		cpp/src/RCFProto_Java_impl.rc )
    
	TARGET_LINK_LIBRARIES(RCFProto_Java_impl RCFProto RCF ${RCFPROTO_LINKER_INPUT} )

	IF( MSVC )
		SET( COPY_FROM			RCFProto_Java_impl.dll )
	ELSE()
		SET( COPY_FROM			libRCFProto_Java_impl.so )
	ENDIF()

	ADD_CUSTOM_COMMAND(
		TARGET					RCFProto_Java_impl
		POST_BUILD
		COMMAND					${CMAKE_COMMAND} -E make_directory							${RCFPROTO_ROOT}/java/bin/${CONF_NAME}
		COMMAND					${CMAKE_COMMAND} -E copy ${COPY_FROM}						${RCFPROTO_ROOT}/java/bin/${CONF_NAME}
		COMMAND					${CMAKE_COMMAND} -E copy ${PROTOBUF_PROTOC_EXECUTABLE}		${RCFPROTO_ROOT}/java/bin
		COMMAND					${CMAKE_COMMAND} -E copy ${PROTOBUF_JAVA_CLASS_PATH}		${RCFPROTO_ROOT}/java/bin
		WORKING_DIRECTORY		${LIBRARY_OUTPUT_PATH} )

	ADD_DEPENDENCIES(build RCFProto_Java_impl)

ENDIF()

# Build RCFProto Python native DLL.
IF(PYTHONLIBS_FOUND)

	ADD_LIBRARY(
		RCFProto_Python_impl
		SHARED
		cpp/src/swig/RCFProto_Python_impl.cpp
		cpp/src/RCFProto_Python_impl.rc )

	SET_TARGET_PROPERTIES(
		RCFProto_Python_impl
		PROPERTIES COMPILE_FLAGS "-I${PYTHON_INCLUDE_DIRS}"
	)
 
	TARGET_LINK_LIBRARIES(RCFProto_Python_impl RCFProto RCF ${RCFPROTO_LINKER_INPUT} ${PYTHON_LIBRARIES} )

	ADD_DEPENDENCIES(build RCFProto_Python_impl)

	# Copy Python extension lib to the specific name that Python requires (OS dependent).
	IF( MSVC )
		SET( COPY_FROM			RCFProto_Python_impl.dll )
		SET( COPY_TO			_rcfproto.pyd )
	ELSE()
		SET( COPY_FROM			libRCFProto_Python_impl.so )
		SET( COPY_TO			_rcfproto.so )
	ENDIF()
	
	ADD_CUSTOM_COMMAND(
		TARGET					RCFProto_Python_impl
		POST_BUILD
		COMMAND					${CMAKE_COMMAND} -E copy ${COPY_FROM}  ${COPY_TO}
		WORKING_DIRECTORY		${LIBRARY_OUTPUT_PATH} )

	ADD_CUSTOM_COMMAND(
		TARGET					RCFProto_Python_impl
		POST_BUILD
		COMMAND					${CMAKE_COMMAND} -E make_directory							${RCFPROTO_ROOT}/python/bin/${CONF_NAME}
		COMMAND					${CMAKE_COMMAND} -E copy	${COPY_TO}						${RCFPROTO_ROOT}/python/bin/${CONF_NAME}
		COMMAND					${CMAKE_COMMAND} -E copy	${PROTOBUF_PROTOC_EXECUTABLE}	${RCFPROTO_ROOT}/python/bin
		WORKING_DIRECTORY		${LIBRARY_OUTPUT_PATH} )

ENDIF()

# C++ test target

ADD_CUSTOM_TARGET(
	CppDemoDir
	DEPENDS						${LIBRARY_OUTPUT_PATH}/demo_cpp/touch
	SOURCES						${RCFPROTO_ROOT}/CMakeLists.txt)

ADD_CUSTOM_COMMAND(
	OUTPUT						${LIBRARY_OUTPUT_PATH}/demo_cpp/touch
	DEPENDS						${RCFPROTO_ROOT}/CMakeLists.txt
	COMMAND						${CMAKE_COMMAND} -E make_directory		${LIBRARY_OUTPUT_PATH}/demo_cpp
	COMMAND						${CMAKE_COMMAND} -E touch				${LIBRARY_OUTPUT_PATH}/demo_cpp/touch )

ADD_CUSTOM_TARGET(
	CppDemoProto
	DEPENDS						${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.h ${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.cc
	SOURCES						${RCFPROTO_ROOT}/cpp/demo/Demo.proto)

ADD_CUSTOM_COMMAND(
	OUTPUT						${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.h ${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.cc
	DEPENDS						${RCFPROTO_ROOT}/cpp/demo/Demo.proto
	COMMAND						${CMAKE_COMMAND} -E copy ${RCFPROTO_ROOT}/cpp/demo/Demo.proto .
	COMMAND						${PROTOBUF_PROTOC_EXECUTABLE} Demo.proto --cpp_out=.
	WORKING_DIRECTORY			${LIBRARY_OUTPUT_PATH}/demo_cpp )

SET_SOURCE_FILES_PROPERTIES(${LIBRARY_OUTPUT_PATH}/${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.h PROPERTIES GENERATED TRUE)
SET_SOURCE_FILES_PROPERTIES(${LIBRARY_OUTPUT_PATH}/${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.cc PROPERTIES GENERATED TRUE)
ADD_DEPENDENCIES(CppDemoProto CppDemoDir)

INCLUDE_DIRECTORIES(
	${LIBRARY_OUTPUT_PATH}/demo_cpp )

ADD_EXECUTABLE(
    DemoServerCpp
    ${RCFPROTO_ROOT}/cpp/demo/DemoServer.cpp
	${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.cc )

TARGET_LINK_LIBRARIES( DemoServerCpp RCFProto RCF ${RCFPROTO_LINKER_INPUT} )

ADD_EXECUTABLE(
    DemoClientCpp
	${RCFPROTO_ROOT}/cpp/demo/DemoClient.cpp
	${LIBRARY_OUTPUT_PATH}/demo_cpp/Demo.pb.cc )

TARGET_LINK_LIBRARIES( DemoClientCpp RCFProto RCF ${RCFPROTO_LINKER_INPUT} )

SET_SOURCE_FILES_PROPERTIES(${LIBRARY_OUTPUT_PATH}/DemoServerCpp.exe PROPERTIES GENERATED TRUE)
SET_SOURCE_FILES_PROPERTIES(${LIBRARY_OUTPUT_PATH}/DemoClientCpp.exe PROPERTIES GENERATED TRUE)

ADD_CUSTOM_TARGET( 
	CppDemo
	DEPENDS				${LIBRARY_OUTPUT_PATH}/CppDemo.stdout.txt
	SOURCES				${LIBRARY_OUTPUT_PATH}/DemoServerCpp.exe ${LIBRARY_OUTPUT_PATH}/DemoClientCpp.exe )

ADD_CUSTOM_COMMAND(
	OUTPUT				${LIBRARY_OUTPUT_PATH}/CppDemo.stdout.txt
	DEPENDS				${LIBRARY_OUTPUT_PATH}/DemoServerCpp.exe ${LIBRARY_OUTPUT_PATH}/DemoClientCpp.exe 
	COMMAND				${RUN_ASYNC_PRE} DemoServerCpp ${RUN_ASYNC_POST}
	COMMAND				DemoClientCpp --delay 1000
	COMMAND				DemoClientCpp --shutdown > CppDemo.stdout.txt
	WORKING_DIRECTORY	${LIBRARY_OUTPUT_PATH})

ADD_DEPENDENCIES(demo CppDemo)
ADD_DEPENDENCIES(CppDemo DemoServerCpp DemoClientCpp)
ADD_DEPENDENCIES(DemoServerCpp CppDemoProto)
ADD_DEPENDENCIES(DemoClientCpp CppDemoProto)

ADD_DEPENDENCIES(build DemoServerCpp)
ADD_DEPENDENCIES(build DemoClientCpp)

# Build Python, Java and C# targets as appropriate.
INCLUDE( cmake/PythonTargets.txt )
INCLUDE( cmake/JavaTargets.txt )
INCLUDE( cmake/CSharpTargets.txt )
