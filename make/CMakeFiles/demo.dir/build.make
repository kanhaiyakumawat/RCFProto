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
include CMakeFiles/demo.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/demo.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/demo.dir/flags.make

CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o: CMakeFiles/demo.dir/flags.make
CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o: ../cpp/src/Dummy.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o -c /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/Dummy.cpp

CMakeFiles/demo.dir/cpp/src/Dummy.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/demo.dir/cpp/src/Dummy.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/Dummy.cpp > CMakeFiles/demo.dir/cpp/src/Dummy.cpp.i

CMakeFiles/demo.dir/cpp/src/Dummy.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/demo.dir/cpp/src/Dummy.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/cpp/src/Dummy.cpp -o CMakeFiles/demo.dir/cpp/src/Dummy.cpp.s

CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.requires:
.PHONY : CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.requires

CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.provides: CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.requires
	$(MAKE) -f CMakeFiles/demo.dir/build.make CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.provides.build
.PHONY : CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.provides

CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.provides.build: CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o

# Object files for target demo
demo_OBJECTS = \
"CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o"

# External object files for target demo
demo_EXTERNAL_OBJECTS =

libdemo.a: CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o
libdemo.a: CMakeFiles/demo.dir/build.make
libdemo.a: CMakeFiles/demo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libdemo.a"
	$(CMAKE_COMMAND) -P CMakeFiles/demo.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/demo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/demo.dir/build: libdemo.a
.PHONY : CMakeFiles/demo.dir/build

CMakeFiles/demo.dir/requires: CMakeFiles/demo.dir/cpp/src/Dummy.cpp.o.requires
.PHONY : CMakeFiles/demo.dir/requires

CMakeFiles/demo.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/demo.dir/cmake_clean.cmake
.PHONY : CMakeFiles/demo.dir/clean

CMakeFiles/demo.dir/depend:
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/make/CMakeFiles/demo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/demo.dir/depend

