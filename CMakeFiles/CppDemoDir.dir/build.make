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

# Utility rule file for CppDemoDir.

# Include the progress variables for this target.
include CMakeFiles/CppDemoDir.dir/progress.make

CMakeFiles/CppDemoDir: demo_cpp/touch

demo_cpp/touch: CMakeLists.txt
	$(CMAKE_COMMAND) -E cmake_progress_report /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating demo_cpp/touch"
	/usr/bin/cmake -E make_directory /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/demo_cpp
	/usr/bin/cmake -E touch /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/demo_cpp/touch

CppDemoDir: CMakeFiles/CppDemoDir
CppDemoDir: demo_cpp/touch
CppDemoDir: CMakeFiles/CppDemoDir.dir/build.make
.PHONY : CppDemoDir

# Rule to build all files generated by this target.
CMakeFiles/CppDemoDir.dir/build: CppDemoDir
.PHONY : CMakeFiles/CppDemoDir.dir/build

CMakeFiles/CppDemoDir.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/CppDemoDir.dir/cmake_clean.cmake
.PHONY : CMakeFiles/CppDemoDir.dir/clean

CMakeFiles/CppDemoDir.dir/depend:
	cd /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0 /home/kanhaiyakumawat/hashmap/RCFProto-src-1.1.0.0/CMakeFiles/CppDemoDir.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/CppDemoDir.dir/depend
