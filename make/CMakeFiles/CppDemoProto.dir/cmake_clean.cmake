FILE(REMOVE_RECURSE
  "CMakeFiles/CppDemoProto"
  "demo_cpp/Demo.pb.h"
  "demo_cpp/Demo.pb.cc"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/CppDemoProto.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
