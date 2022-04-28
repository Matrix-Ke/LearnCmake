cmake_minimum_required(VERSION 3.15)
project(MatrixTutorial VERSION 1.0.0)

#=====================================全局变量设置=======================================
set(CMAKE_DEBUG_POSTFIX d)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")


#=======================利用生成器表达式，设置c+++ standard，配置环境====================
add_library(tutorial_compiler_flags  INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
target_compile_options(tutorial_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)




#=============================================config文件生成=================================
#默认config结果保存到build文件夹中，默认TutorialConfig.h将生成到PROJECT_BINARY_DIR文件夹中
message(STATUS configPath= ${PROJECT_BINARY_DIR})
configure_file(TutorialConfig.h.in  TutorialConfig.h)


#============================================可执行文件配置=================================
add_executable(MatrixTutorial  tutorial.cpp)
set_target_properties(MatrixTutorial PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}) #设置文件后缀
option(BUILD_SHARED_LIBS  "build using shared lib" ON) #BUILD_SHARED_LIBS 控制static和share库的 PIC 位置无关代码  

add_subdirectory(MathFunctions) # 添加子文件夹
target_include_directories(MatrixTutorial PUBLIC  
    # "${PROJECT_BINARY_DIR}"
    # "${PROJECT_SOURCE_DIR}/MathFunctions"
    $<INSTALL_INTERFACE:include>
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR};${PROJECT_SOURCE_DIR}/MathFunctions>
    
)
target_link_libraries(MatrixTutorial PUBLIC 
    MathFunctions
)


#=================================================安装程序================================================
# 默认生成到PROJECT_BINARY_DIR文件夹中, 也可以指定prefix 类如： 
# cmake --install . --prefix "/home/myuser/installdir"
install(TARGETS MatrixTutorial  
        EXPORT MatrixTutorialTargets        
        DESTINATION Bin) # 此install主要是单纯install不进行导出信息
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h" DESTINATION include)
install(EXPORT MathFunctionsTargets  
        FILE MathFunctionsTargets.cmake  DESTINATION Bin/cmake
        # NAMESPACE myLib:: // 可以加上namespace 
)
install(EXPORT MatrixTutorialTargets  
  FILE MatrixTutorialTargets.cmake  DESTINATION Bin/cmake
  # NAMESPACE myLib:: // 可以加上namespace
)
include(CMakePackageConfigHelpers)
# generate the config file that is includes the exports
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "Bin/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)
#Finally, set both generated files to be installed: （需要将生成的config.cmake和ConfigVersion.cmake 文件install到相关位置）
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake
    DESTINATION Bin/cmake
)



# ========================================CPack用于打包=============================================
include(InstallRequiredSystemLibraries)
set(cpack_source_file_license "${CMAKE_CURRENT_SOURCE_DIR}/License.txt" )
set(cpack_pacage_version__major "${Tutorial_VERSION_MAJOR}")
set(cpack_package_version_minor "${Tutorial_VERSION_MINOR}")
#The CPACK_SOURCE_GENERATOR variable selects a file format for the source package
set(CPACK_SOURCE_GENERATOR  "TGZ")
include(CPack)





#===============================================导出编译目录=========================================
#（这种方式不需要第三方库作为子文件夹放在使用者的项目中，它只需要导出编译目录，然后将 target 导出到 $HOME/.cmake/packages 供使用）
set(CMAKE_EXPORT_PACKAGE_REGISTRY ON)
export(EXPORT MathFunctionsTargets
      FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)



























