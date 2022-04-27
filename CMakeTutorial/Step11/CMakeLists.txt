cmake_minimum_required(VERSION 3.15)

project(MatrixTutorial VERSION 1.0.0 )

#设置c+++ standard 
add_library(tutorial_compiler_flags  INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
target_compile_options(tutorial_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

#此命令用于测试
add_custom_target(GenDebug COMMAND ${CMAKE_COMMAND} -E echo "Bool:hello")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
option(BUILD_SHARED_LIBS  "build using shared lib" ON)
#默认config结果保存到build文件夹中，默认TutorialConfig.h将生成到PROJECT_BINARY_DIR文件夹中

message(STATUS configPath= ${PROJECT_BINARY_DIR})
configure_file(TutorialConfig.h.in  TutorialConfig.h)

add_subdirectory(MathFunctions)



add_executable(MatrixTutorial  tutorial.cpp)
target_link_libraries(MatrixTutorial PUBLIC 
    MathFunctions
)


target_include_directories(MatrixTutorial PUBLIC  
    "${PROJECT_BINARY_DIR}"
    "${PROJECT_SOURCE_DIR}/MathFunctions"
)


#=================================安装程序=================================
# 默认生成到PROJECT_BINARY_DIR文件夹中, 也可以指定prefix 类如： 
# cmake --install . --prefix "/home/myuser/installdir"
install(TARGETS MatrixTutorial  DESTINATION Bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h" DESTINATION include)































