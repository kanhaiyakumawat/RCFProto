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
include CMakeFiles/build.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/build.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/build.dir/flags.make

CMakeFiles/build.dir/cpp/src/Dummy.cpp.o: CMakeFiles/build.dir/flags.make
CMakeFiles/build.dir/cpp/src/Dummy.cpp.o: cpp/src/Dummy.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/build.dir/cpp/src/Dummy.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/build.dir/cpp/src/Dummy.cpp.o -c /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/Dummy.cpp

CMakeFiles/build.dir/cpp/src/Dummy.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/build.dir/cpp/src/Dummy.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/Dummy.cpp > CMakeFiles/build.dir/cpp/src/Dummy.cpp.i

CMakeFiles/build.dir/cpp/src/Dummy.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/build.dir/cpp/src/Dummy.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/Dummy.cpp -o CMakeFiles/build.dir/cpp/src/Dummy.cpp.s

CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.requires:
.PHONY : CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.requires

CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.provides: CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.requires
	$(MAKE) -f CMakeFiles/build.dir/build.make CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.provides.build
.PHONY : CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.provides

CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.provides.build: CMakeFiles/build.dir/cpp/src/Dummy.cpp.o

# Object files for target build
build_OBJECTS = \
"CMakeFiles/build.dir/cpp/src/Dummy.cpp.o"

# External object files for target build
build_EXTERNAL_OBJECTS =

libbuild.a: CMakeFiles/build.dir/cpp/src/Dummy.cpp.o
libbuild.a: CMakeFiles/build.dir/build.make
libbuild.a: CMakeFiles/build.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libbuild.a"
	$(CMAKE_COMMAND) -P CMakeFiles/build.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/build.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/build.dir/build: libbuild.a
.PHONY : CMakeFiles/build.dir/build

CMakeFiles/build.dir/requires: CMakeFiles/build.dir/cpp/src/Dummy.cpp.o.requires
.PHONY : CMakeFiles/build.dir/requires

CMakeFiles/build.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/build.dir/cmake_clean.cmake
.PHONY : CMakeFiles/build.dir/clean

CMakeFiles/build.dir/depend:
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles/build.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/build.dir/depend

