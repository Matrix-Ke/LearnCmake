cmake_minimum_required(VERSION 3.15)
project(MatrixTutorial VERSION 1.0.0)

set(CMAKE_DEBUG_POSTFIX d)


#利用生成器表达式，设置c+++ standard，配置windows环境
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

#BUILD_SHARED_LIBS 控制static和share库的 PIC 位置无关代码  
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
option(BUILD_SHARED_LIBS  "build using shared lib" ON)

#默认config结果保存到build文件夹中，默认TutorialConfig.h将生成到PROJECT_BINARY_DIR文件夹中
message(STATUS configPath= ${PROJECT_BINARY_DIR})
configure_file(TutorialConfig.h.in  TutorialConfig.h)

add_subdirectory(MathFunctions)



add_executable(MatrixTutorial  tutorial.cpp)
set_target_properties(Tutorial PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})

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
target_include_directories(MathFunctions
                           INTERFACE
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                            $<INSTALL_INTERFACE:include>
                           )
install(EXPORT MathFunctionsTargets
  FILE MathFunctionsTargets.cmake
  DESTINATION lib/cmake/MathFunctions
)

include(CMakePackageConfigHelpers)
# generate the config file that is includes the exports
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)

install(FILES
${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake
DESTINATION lib/cmake/MathFunctions
)

export(EXPORT MathFunctionsTargets
FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)



























