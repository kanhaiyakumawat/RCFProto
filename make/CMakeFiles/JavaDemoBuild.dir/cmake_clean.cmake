FILE(REMOVE_RECURSE
  "CMakeFiles/JavaDemoBuild"
  "RCFProto.jar"
  "demo_java/DemoClient.class"
  "demo_java/DemoServer.class"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/JavaDemoBuild.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
