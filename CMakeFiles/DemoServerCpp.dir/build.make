# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

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

# Include any dependencies generated for this target.
include CMakeFiles/DemoServerCpp.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/DemoServerCpp.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/DemoServerCpp.dir/flags.make

demo_cpp/Demo.pb.h: cpp/demo/Demo.proto
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating demo_cpp/Demo.pb.h, demo_cpp/Demo.pb.cc"
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/demo_cpp && /usr/bin/cmake -E copy /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/demo/Demo.proto .
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/demo_cpp && /usr/bin/protoc Demo.proto --cpp_out=.

demo_cpp/Demo.pb.cc: demo_cpp/Demo.pb.h

CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o: CMakeFiles/DemoServerCpp.dir/flags.make
CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o: cpp/demo/DemoServer.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o -c /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/demo/DemoServer.cpp

CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/demo/DemoServer.cpp > CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.i

CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/demo/DemoServer.cpp -o CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.s

CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.requires:
.PHONY : CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.requires

CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.provides: CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.requires
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.provides.build
.PHONY : CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.provides

CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.provides.build: CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o

CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o: CMakeFiles/DemoServerCpp.dir/flags.make
CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o: demo_cpp/Demo.pb.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o -c /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/demo_cpp/Demo.pb.cc

CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/demo_cpp/Demo.pb.cc > CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.i

CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/demo_cpp/Demo.pb.cc -o CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.s

CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.requires:
.PHONY : CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.requires

CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.provides: CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.requires
	$(MAKE) -f CMakeFiles/DemoServerCpp.dir/build.make CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.provides.build
.PHONY : CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.provides

CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.provides.build: CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o

# Object files for target DemoServerCpp
DemoServerCpp_OBJECTS = \
"CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o" \
"CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o"

# External object files for target DemoServerCpp
DemoServerCpp_EXTERNAL_OBJECTS =

DemoServerCpp: CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o
DemoServerCpp: CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o
DemoServerCpp: CMakeFiles/DemoServerCpp.dir/build.make
DemoServerCpp: libRCFProto.a
DemoServerCpp: libRCF.a
DemoServerCpp: /usr/lib/x86_64-linux-gnu/libprotobuf.so
DemoServerCpp: CMakeFiles/DemoServerCpp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable DemoServerCpp"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/DemoServerCpp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/DemoServerCpp.dir/build: DemoServerCpp
.PHONY : CMakeFiles/DemoServerCpp.dir/build

CMakeFiles/DemoServerCpp.dir/requires: CMakeFiles/DemoServerCpp.dir/cpp/demo/DemoServer.cpp.o.requires
CMakeFiles/DemoServerCpp.dir/requires: CMakeFiles/DemoServerCpp.dir/demo_cpp/Demo.pb.cc.o.requires
.PHONY : CMakeFiles/DemoServerCpp.dir/requires

CMakeFiles/DemoServerCpp.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/DemoServerCpp.dir/cmake_clean.cmake
.PHONY : CMakeFiles/DemoServerCpp.dir/clean

CMakeFiles/DemoServerCpp.dir/depend: demo_cpp/Demo.pb.h
CMakeFiles/DemoServerCpp.dir/depend: demo_cpp/Demo.pb.cc
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles/DemoServerCpp.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/DemoServerCpp.dir/depend

