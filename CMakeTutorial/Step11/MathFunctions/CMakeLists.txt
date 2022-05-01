#==========================================库目标生成=================================
add_library(MathFunctions  SHARED  MathFunctions.cpp)
set_property(TARGET MathFunctions PROPERTY VERSION "1.0.0") # 将版本编号添加到MathFunctions库中
set_property(TARGET MathFunctions PROPERTY SOVERSION "1")
# interface 含义： 暴露给外部需要使用这个库以这个头文件，但是该库cpp自身是不需要的额外inlcude的
target_include_directories(MathFunctions
                            INTERFACE
                            # ${CMAKE_CURRENT_SOURCE_DIR}  我也不知道为啥要改成这样，但是就是改成这样才能运行cmake。
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                            $<INSTALL_INTERFACE:include>
                           )


#==========================================生成器表达式 Debug===================================== 
file(GENERATE OUTPUT "./generator_test.txt" CONTENT "$<IF:0,${CMAKE_CURRENT_BINARY_DIR}, ${CMAKE_CURRENT_SOURCE_DIR}>\n")


#对库目标的依赖库，宏定义，库属性进行设置
target_link_libraries(MathFunctions PUBLIC tutorial_compiler_flags)
option(USE_MYMATH "use tutorial provide math function" ON)
if(USE_MYMATH)
    target_compile_definitions(MathFunctions PRIVATE "USE_MYMATH")
    add_executable(MakeTable  MakeTable.cpp)
    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
        COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
        DEPENDS MakeTable
    )
    add_library(SqrtLibrary STATIC
        mysqrt.cpp
        ${CMAKE_CURRENT_BINARY_DIR}/Table.h
        )

    # state that we depend on our binary dir to find Table.h
    target_include_directories(SqrtLibrary PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}
    )
    # state that SqrtLibrary need PIC when the default is shared libraries
    set_target_properties(SqrtLibrary PROPERTIES 
                                POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
                                # POSITION_INDEPENDENT_CODE TRUE
    )
    target_link_libraries(SqrtLibrary PUBLIC tutorial_compiler_flags)
    message(STATUS BUILD_SHARED_LIBS = ${BUILD_SHARED_LIBS})
    target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
endif()
# define the symbol stating we are using the declspec(dllexport) when building on windows
target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")




#========================================安装指令====================================
#执行安装程序， 将外部库和程序安装到指定位置
set(installable_libs "MathFunctions;tutorial_compiler_flags")
if(TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()
install(TARGETS  ${installable_libs}
    EXPORT  MathFunctionsTargets
    RUNTIME DESTINATION  Bin
    LIBRARY DESTINATION  Lib
    ARCHIVE DESTINATION  Lib
)
install(FILES MathFunctions.h  DESTINATION  include)
install(EXPORT MathFunctionsTargets 
        FILE MathFunctionsTargets.cmake
        DESTINATION cmake
)
include(CMakePackageConfigHelpers)
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
    INSTALL_DESTINATION  cmake
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
    VERSION  "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
    COMPATIBILITY AnyNewerVersion
)
#Finally, set both generated files to be installed: （需要将生成的config.cmake和ConfigVersion.cmake 文件install到相关位置）
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake
    DESTINATION cmake
)

#===============================================导出编译目录=========================================
#（这种方式不需要第三方库作为子文件夹放在使用者的项目中，它只需要导出编译目录，就是直接在编译目录下使用。 
# set(CMAKE_EXPORT_PACKAGE_REGISTRY ON)
# export(EXPORT MathFunctionsTargets
#       FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
# )




