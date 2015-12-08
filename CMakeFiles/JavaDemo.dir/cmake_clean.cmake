FILE(REMOVE_RECURSE
  "CMakeFiles/JavaDemo"
  "RCFProto.jar"
  "demo_java/DemoClient.stdout.txt"
  "demo_java/DemoClient.class"
  "demo_java/DemoServer.class"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/JavaDemo.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
