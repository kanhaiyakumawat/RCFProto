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
CMAKE_BINARY_DIR = /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make

# Include any dependencies generated for this target.
include CMakeFiles/RCFProto.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/RCFProto.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/RCFProto.dir/flags.make

CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o: CMakeFiles/RCFProto.dir/flags.make
CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o: ../cpp/src/RCFProto.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o -c /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/RCFProto.cpp

CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/RCFProto.cpp > CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.i

CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/RCFProto.cpp -o CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.s

CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.requires:
.PHONY : CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.requires

CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.provides: CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.requires
	$(MAKE) -f CMakeFiles/RCFProto.dir/build.make CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.provides.build
.PHONY : CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.provides

CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.provides.build: CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o

# Object files for target RCFProto
RCFProto_OBJECTS = \
"CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o"

# External object files for target RCFProto
RCFProto_EXTERNAL_OBJECTS =

libRCFProto.a: CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o
libRCFProto.a: CMakeFiles/RCFProto.dir/build.make
libRCFProto.a: CMakeFiles/RCFProto.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libRCFProto.a"
	$(CMAKE_COMMAND) -P CMakeFiles/RCFProto.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/RCFProto.dir/link.txt --verbose=$(VERBOSE)
	/usr/bin/cmake -E make_directory /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/bin
	/usr/bin/cmake -E copy /usr/bin/protoc /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/bin

# Rule to build all files generated by this target.
CMakeFiles/RCFProto.dir/build: libRCFProto.a
.PHONY : CMakeFiles/RCFProto.dir/build

CMakeFiles/RCFProto.dir/requires: CMakeFiles/RCFProto.dir/cpp/src/RCFProto.cpp.o.requires
.PHONY : CMakeFiles/RCFProto.dir/requires

CMakeFiles/RCFProto.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/RCFProto.dir/cmake_clean.cmake
.PHONY : CMakeFiles/RCFProto.dir/clean

CMakeFiles/RCFProto.dir/depend:
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make/CMakeFiles/RCFProto.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/RCFProto.dir/depend

