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
include CMakeFiles/RCFProto_Java_impl.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/RCFProto_Java_impl.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/RCFProto_Java_impl.dir/flags.make

CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o: CMakeFiles/RCFProto_Java_impl.dir/flags.make
CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o: cpp/src/swig/RCFProto_Java_impl.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o -c /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/swig/RCFProto_Java_impl.cpp

CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/swig/RCFProto_Java_impl.cpp > CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.i

CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/swig/RCFProto_Java_impl.cpp -o CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.s

CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.requires:
.PHONY : CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.requires

CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.provides: CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.requires
	$(MAKE) -f CMakeFiles/RCFProto_Java_impl.dir/build.make CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.provides.build
.PHONY : CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.provides

CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.provides.build: CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o

# Object files for target RCFProto_Java_impl
RCFProto_Java_impl_OBJECTS = \
"CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o"

# External object files for target RCFProto_Java_impl
RCFProto_Java_impl_EXTERNAL_OBJECTS =

libRCFProto_Java_impl.so: CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o
libRCFProto_Java_impl.so: CMakeFiles/RCFProto_Java_impl.dir/build.make
libRCFProto_Java_impl.so: libRCFProto.a
libRCFProto_Java_impl.so: libRCF.a
libRCFProto_Java_impl.so: /usr/lib/x86_64-linux-gnu/libprotobuf.so
libRCFProto_Java_impl.so: CMakeFiles/RCFProto_Java_impl.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared library libRCFProto_Java_impl.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/RCFProto_Java_impl.dir/link.txt --verbose=$(VERBOSE)
	/usr/bin/cmake -E make_directory /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/java/bin/x64
	/usr/bin/cmake -E copy libRCFProto_Java_impl.so /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/java/bin/x64
	/usr/bin/cmake -E copy /usr/bin/protoc /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/java/bin
	/usr/bin/cmake -E copy /usr/share/java/protobuf.jar /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/java/bin

# Rule to build all files generated by this target.
CMakeFiles/RCFProto_Java_impl.dir/build: libRCFProto_Java_impl.so
.PHONY : CMakeFiles/RCFProto_Java_impl.dir/build

CMakeFiles/RCFProto_Java_impl.dir/requires: CMakeFiles/RCFProto_Java_impl.dir/cpp/src/swig/RCFProto_Java_impl.cpp.o.requires
.PHONY : CMakeFiles/RCFProto_Java_impl.dir/requires

CMakeFiles/RCFProto_Java_impl.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/RCFProto_Java_impl.dir/cmake_clean.cmake
.PHONY : CMakeFiles/RCFProto_Java_impl.dir/clean

CMakeFiles/RCFProto_Java_impl.dir/depend:
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles/RCFProto_Java_impl.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/RCFProto_Java_impl.dir/depend
