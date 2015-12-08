# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running interactive CMake command-line interface..."
	/usr/bin/cmake -i .
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles/progress.marks
	$(MAKE) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named CppDemo

# Build rule for target.
CppDemo: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 CppDemo
.PHONY : CppDemo

# fast build rule for target.
CppDemo/fast:
	$(MAKE) -f CMakeFiles/CppDemo.dir/build.make CMakeFiles/CppDemo.dir/build
.PHONY : CppDemo/fast

#=============================================================================
# Target rules for targets named CppDemoDir

# Build rule for target.
CppDemoDir: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 CppDemoDir
.PHONY : CppDemoDir

# fast build rule for target.
CppDemoDir/fast:
	$(MAKE) -f CMakeFiles/CppDemoDir.dir/build.make CMakeFiles/CppDemoDir.dir/build
.PHONY : CppDemoDir/fast

#=============================================================================
# Target rules for targets named CppDemoProto

# Build rule for target.
CppDemoProto: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 CppDemoProto
.PHONY : CppDemoProto

# fast build rule for target.
CppDemoProto/fast:
	$(MAKE) -f CMakeFiles/CppDemoProto.dir/build.make CMakeFiles/CppDemoProto.dir/build
.PHONY : CppDemoProto/fast

#=============================================================================
# Target rules for targets named DemoClientCpp

# Build rule for target.
DemoClientCpp: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 DemoClientCpp
.PHONY : DemoClientCpp

# fast build rule for target.
DemoClientCpp/fast:
	$(MAKE) -f CMakeFiles/DemoClientCpp.dir/build.make CMakeFiles/DemoClientCpp.dir/build
.PHONY : DemoClientCpp/fast

#=============================================================================
# Target rules for targets named DemoServerCpp

# Build rule for target.
DemoServerCpp: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 DemoServerCpp
.PHONY : DemoServerCpp

# fast build rule for target.
DemoServerCpp/fast:
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/build
.PHONY : DemoServerCpp/fast

#=============================================================================
# Target rules for targets named JavaDemo

# Build rule for target.
JavaDemo: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 JavaDemo
.PHONY : JavaDemo

# fast build rule for target.
JavaDemo/fast:
	$(MAKE) -f CMakeFiles/JavaDemo.dir/build.make CMakeFiles/JavaDemo.dir/build
.PHONY : JavaDemo/fast

#=============================================================================
# Target rules for targets named JavaDemoBuild

# Build rule for target.
JavaDemoBuild: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 JavaDemoBuild
.PHONY : JavaDemoBuild

# fast build rule for target.
JavaDemoBuild/fast:
	$(MAKE) -f CMakeFiles/JavaDemoBuild.dir/build.make CMakeFiles/JavaDemoBuild.dir/build
.PHONY : JavaDemoBuild/fast

#=============================================================================
# Target rules for targets named RCF

# Build rule for target.
RCF: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 RCF
.PHONY : RCF

# fast build rule for target.
RCF/fast:
	$(MAKE) -f CMakeFiles/RCF.dir/build.make CMakeFiles/RCF.dir/build
.PHONY : RCF/fast

#=============================================================================
# Target rules for targets named RCFProto

# Build rule for target.
RCFProto: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 RCFProto
.PHONY : RCFProto

# fast build rule for target.
RCFProto/fast:
	$(MAKE) -f CMakeFiles/RCFProto.dir/build.make CMakeFiles/RCFProto.dir/build
.PHONY : RCFProto/fast

#=============================================================================
# Target rules for targets named RCFProtoJar

# Build rule for target.
RCFProtoJar: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 RCFProtoJar
.PHONY : RCFProtoJar

# fast build rule for target.
RCFProtoJar/fast:
	$(MAKE) -f CMakeFiles/RCFProtoJar.dir/build.make CMakeFiles/RCFProtoJar.dir/build
.PHONY : RCFProtoJar/fast

#=============================================================================
# Target rules for targets named RCFProto_Java_impl

# Build rule for target.
RCFProto_Java_impl: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 RCFProto_Java_impl
.PHONY : RCFProto_Java_impl

# fast build rule for target.
RCFProto_Java_impl/fast:
	$(MAKE) -f CMakeFiles/RCFProto_Java_impl.dir/build.make CMakeFiles/RCFProto_Java_impl.dir/build
.PHONY : RCFProto_Java_impl/fast

#=============================================================================
# Target rules for targets named build

# Build rule for target.
build: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 build
.PHONY : build

# fast build rule for target.
build/fast:
	$(MAKE) -f CMakeFiles/build.dir/build.make CMakeFiles/build.dir/build
.PHONY : build/fast

#=============================================================================
# Target rules for targets named demo

# Build rule for target.
demo: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 demo
.PHONY : demo

# fast build rule for target.
demo/fast:
	$(MAKE) -f CMakeFiles/demo.dir/build.make CMakeFiles/demo.dir/build
.PHONY : demo/fast

#=============================================================================
# Target rules for targets named test

# Build rule for target.
test: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 test
.PHONY : test

# fast build rule for target.
test/fast:
	$(MAKE) -f CMakeFiles/test.dir/build.make CMakeFiles/test.dir/build
.PHONY : test/fast

cpp/demo/DemoClient.o: cpp/demo/DemoClient.cpp.o
.PHONY : cpp/demo/DemoClient.o

# target to build an object file
cpp/demo/DemoClient.cpp.o:
	$(MAKE) -f CMakeFiles/DemoClientCpp.dir/build.make CMakeFiles/DemoClientCpp.dir/cpp/demo/DemoClient.cpp.o
.PHONY : cpp/demo/DemoClient.cpp.o

cpp/demo/DemoClient.i: cpp/demo/DemoClient.cpp.i
.PHONY : cpp/demo/DemoClient.i

# target to preprocess a source file
cpp/demo/DemoClient.cpp.i:
	$(MAKE) -f CMakeFiles/DemoClientCpp.dir/build.make CMakeFiles/DemoClientCpp.dir/cpp/demo/DemoClient.cpp.i
.PHONY : cpp/demo/DemoClient.cpp.i

cpp/demo/DemoClient.s: cpp/demo/DemoClient.cpp.s
.PHONY : cpp/demo/DemoClient.s

# target to generate assembly for a file
cpp/demo/DemoClient.cpp.s:
	$(MAKE) -f CMakeFiles/DemoClientCpp.dir/build.make CMakeFiles/DemoClientCpp.dir/cpp/demo/DemoClient.cpp.s
.PHONY : cpp/demo/DemoClient.cpp.s

cpp/demo/DemoServer.o: cpp/demo/DemoServer.cpp.o
.PHONY : cpp/demo/DemoServer.o

# target to build an object file
cpp/demo/DemoServer.cpp.o:
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o
.PHONY : cpp/demo/DemoServer.cpp.o

cpp/demo/DemoServer.i: cpp/demo/DemoServer.cpp.i
.PHONY : cpp/demo/DemoServer.i

# target to preprocess a source file
cpp/demo/DemoServer.cpp.i:
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.i
.PHONY : cpp/demo/DemoServer.cpp.i

cpp/demo/DemoServer.s: cpp/demo/DemoServer.cpp.s
.PHONY : cpp/demo/DemoServer.s

# target to generate assembly for a file
cpp/demo/DemoServer.cpp.s:
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.s
.PHONY : cpp/demo/DemoServer.cpp.s

cpp/src/Dummy.o: cpp/src/Dummy.cpp.o
.PHONY : cpp/src/Dummy.o

# target to build an object file
cpp/src/Dummy.cpp.o:
	$(MAKE) -f CMakeFiles/build.dir/build.make CMakeFiles/build.dir/cpp/src/Dummy.cpp.o
	$(MAKE) -f CMakeFiles/demo.dir/build.make CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o
	$(MAKE) -f CMakeFiles/test.dir/build.make CMakeFiles/test.dir/cpp/src/Dummy.cpp.o
.PHONY : cpp/src/Dummy.cpp.o

cpp/src/Dummy.i: cpp/src/Dummy.cpp.i
.PHONY : cpp/src/Dummy.i

# target to preprocess a source file
cpp/src/Dummy.cpp.i:
	$(MAKE) -f CMakeFiles/build.dir/build.make CMakeFiles/build.dir/cpp/src/Dummy.cpp.i
	$(MAKE) -f CMakeFiles/demo.dir/build.make CMakeFiles/demo.dir/cpp/src/Dummy.cpp.i
	$(MAKE) -f CMakeFiles/test.dir/build.make CMakeFiles/test.dir/cpp/src/Dummy.cpp.i
.PHONY : cpp/src/Dummy.cpp.i

cpp/src/Dummy.s: cpp/src/Dummy.cpp.s
.PHONY : cpp/src/Dummy.s

# target to generate assembly for a file
cpp/src/Dummy.cpp.s:
	$(MAKE) -f CMakeFiles/build.dir/build.make CMakeFiles/build.dir/cpp/src/Dummy.cpp.s
	$(MAKE) -f CMakeFiles/demo.dir/build.make CMakeFiles/demo.dir/cpp/src/Dummy.cpp.s
	$(MAKE) -f CMakeFiles/test.dir/build.make CMakeFiles/test.dir/cpp/src/Dummy.cpp.s
.PHONY : cpp/src/Dummy.cpp.s

cpp/src/RCF/src/RCF/RCF.o: cpp/src/RCF/src/RCF/RCF.cpp.o
.PHONY : cpp/src/RCF/src/RCF/RCF.o

# target to build an object file
cpp/src/RCF/src/RCF/RCF.cpp.o:
	$(MAKE) -f CMakeFiles/RCF.dir/build.make CMakeFiles/RCF.dir/cpp/src/RCF/src/RCF/RCF.cpp.o
.PHONY : cpp/src/RCF/src/RCF/RCF.cpp.o

cpp/src/RCF/src/RCF/RCF.i: cpp/src/RCF/src/RCF/RCF.cpp.i
.PHONY : cpp/src/RCF/src/RCF/RCF.i

# target to preprocess a source file
cpp/src/RCF/src/RCF/RCF.cpp.i:
	$(MAKE) -f CMakeFiles/RCF.dir/build.make CMakeFiles/RCF.dir/cpp/src/RCF/src/RCF/RCF.cpp.i
.PHONY : cpp/src/RCF/src/RCF/RCF.cpp.i

cpp/src/RCF/src/RCF/RCF.s: cpp/src/RCF/src/RCF/RCF.cpp.s
.PHONY : cpp/src/RCF/src/RCF/RCF.s

# target to generate assembly for a file
cpp/src/RCF/src/RCF/RCF.cpp.s:
	$(MAKE) -f CMakeFiles/RCF.dir/build.make CMakeFiles/RCF.dir/cpp/src/RCF/src/RCF/RCF.cpp.s
.PHONY : cpp/src/RCF/src/RCF/RCF.cpp.s

cpp/src/RCFProto.o: cpp/src/RCFProto.cpp.o
.PHONY : cpp/src/RCFProto.o

# target to build an object file
cpp/src/RCFProto.cpp.o:
	$(MAKE) -f CMakeFiles/RCFProto.dir/build.make CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o
.PHONY : cpp/src/RCFProto.cpp.o

cpp/src/RCFProto.i: cpp/src/RCFProto.cpp.i
.PHONY : cpp/src/RCFProto.i

# target to preprocess a source file
cpp/src/RCFProto.cpp.i:
	$(MAKE) -f CMakeFiles/RCFProto.dir/build.make CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.i
.PHONY : cpp/src/RCFProto.cpp.i

cpp/src/RCFProto.s: cpp/src/RCFProto.cpp.s
.PHONY : cpp/src/RCFProto.s

# target to generate assembly for a file
cpp/src/RCFProto.cpp.s:
	$(MAKE) -f CMakeFiles/RCFProto.dir/build.make CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.s
.PHONY : cpp/src/RCFProto.cpp.s

cpp/src/swig/RCFProto_Java_impl.o: cpp/src/swig/RCFProto_Java_impl.cpp.o
.PHONY : cpp/src/swig/RCFProto_Java_impl.o

# target to build an object file
cpp/src/swig/RCFProto_Java_impl.cpp.o:
	$(MAKE) -f CMakeFiles/RCFProto_Java_impl.dir/build.make CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o
.PHONY : cpp/src/swig/RCFProto_Java_impl.cpp.o

cpp/src/swig/RCFProto_Java_impl.i: cpp/src/swig/RCFProto_Java_impl.cpp.i
.PHONY : cpp/src/swig/RCFProto_Java_impl.i

# target to preprocess a source file
cpp/src/swig/RCFProto_Java_impl.cpp.i:
	$(MAKE) -f CMakeFiles/RCFProto_Java_impl.dir/build.make CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.i
.PHONY : cpp/src/swig/RCFProto_Java_impl.cpp.i

cpp/src/swig/RCFProto_Java_impl.s: cpp/src/swig/RCFProto_Java_impl.cpp.s
.PHONY : cpp/src/swig/RCFProto_Java_impl.s

# target to generate assembly for a file
cpp/src/swig/RCFProto_Java_impl.cpp.s:
	$(MAKE) -f CMakeFiles/RCFProto_Java_impl.dir/build.make CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.s
.PHONY : cpp/src/swig/RCFProto_Java_impl.cpp.s

demo_cpp/Demo.pb.o: demo_cpp/Demo.pb.cc.o
.PHONY : demo_cpp/Demo.pb.o

# target to build an object file
demo_cpp/Demo.pb.cc.o:
	$(MAKE) -f CMakeFiles/DemoClientCpp.dir/build.make CMakeFiles/DemoClientCpp.dir/demo_cpp/Demo.pb.cc.o
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o
.PHONY : demo_cpp/Demo.pb.cc.o

demo_cpp/Demo.pb.i: demo_cpp/Demo.pb.cc.i
.PHONY : demo_cpp/Demo.pb.i

# target to preprocess a source file
demo_cpp/Demo.pb.cc.i:
	$(MAKE) -f CMakeFiles/DemoClientCpp.dir/build.make CMakeFiles/DemoClientCpp.dir/demo_cpp/Demo.pb.cc.i
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.i
.PHONY : demo_cpp/Demo.pb.cc.i

demo_cpp/Demo.pb.s: demo_cpp/Demo.pb.cc.s
.PHONY : demo_cpp/Demo.pb.s

# target to generate assembly for a file
demo_cpp/Demo.pb.cc.s:
	$(MAKE) -f CMakeFiles/DemoClientCpp.dir/build.make CMakeFiles/DemoClientCpp.dir/demo_cpp/Demo.pb.cc.s
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.s
.PHONY : demo_cpp/Demo.pb.cc.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... CppDemo"
	@echo "... CppDemoDir"
	@echo "... CppDemoProto"
	@echo "... DemoClientCpp"
	@echo "... DemoServerCpp"
	@echo "... JavaDemo"
	@echo "... JavaDemoBuild"
	@echo "... RCF"
	@echo "... RCFProto"
	@echo "... RCFProtoJar"
	@echo "... RCFProto_Java_impl"
	@echo "... build"
	@echo "... demo"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... test"
	@echo "... cpp/demo/DemoClient.o"
	@echo "... cpp/demo/DemoClient.i"
	@echo "... cpp/demo/DemoClient.s"
	@echo "... cpp/demo/DemoServer.o"
	@echo "... cpp/demo/DemoServer.i"
	@echo "... cpp/demo/DemoServer.s"
	@echo "... cpp/src/Dummy.o"
	@echo "... cpp/src/Dummy.i"
	@echo "... cpp/src/Dummy.s"
	@echo "... cpp/src/RCF/src/RCF/RCF.o"
	@echo "... cpp/src/RCF/src/RCF/RCF.i"
	@echo "... cpp/src/RCF/src/RCF/RCF.s"
	@echo "... cpp/src/RCFProto.o"
	@echo "... cpp/src/RCFProto.i"
	@echo "... cpp/src/RCFProto.s"
	@echo "... cpp/src/swig/RCFProto_Java_impl.o"
	@echo "... cpp/src/swig/RCFProto_Java_impl.i"
	@echo "... cpp/src/swig/RCFProto_Java_impl.s"
	@echo "... demo_cpp/Demo.pb.o"
	@echo "... demo_cpp/Demo.pb.i"
	@echo "... demo_cpp/Demo.pb.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system
