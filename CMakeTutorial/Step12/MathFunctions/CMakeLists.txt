#==========================================库目标生成=================================
add_library(MathFunctions MathFunctions.cpp MathFunctions.h)
set_property(TARGET MathFunctions PROPERTY VERSION "1.0.0") # 将版本编号添加到MathFunctions库中
set_property(TARGET MathFunctions PROPERTY SOVERSION "1")
# interface 含义： 暴露给外部需要使用这个库以这个头文件，但是该库cpp自身是不需要的额外inlcude的
target_include_directories(MathFunctions
                            INTERFACE 
                            # ${CMAKE_CURRENT_SOURCE_DIR}  #如果是需要导出dll程序则必须要使用BUILD_INTERFACE来进行路径判断，不能直接使用绝对路径
                            # 这个使用了生成器表达式，其他项目引入包的时候就可以同时引入头文件包含路径
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                            $<INSTALL_INTERFACE:include>
                           )


#==========================================生成器表达式 Debug===================================== 
file(GENERATE OUTPUT "./generator_test.txt" CONTENT "$<IF:0,${CMAKE_CURRENT_BINARY_DIR}, ${CMAKE_CURRENT_SOURCE_DIR}>\n")

#文件分组
FILE(GLOB HeaderFiles ./*.h)  #GLOB 获取./include/目录下的*.h 储存在变量HEAD_RIGEL_EDITOR中
FILE(GLOB SourceFiles ./*.cpp)#GLOB 递归获取./include/目录和子目录下的*.cpp 储存在变量HEAD_RIGEL_EDITOR中
# source_group("Header Files" FILES ${HeaderFiles})
# source_group("Source Files" FILES ${SourceFiles})
source_group("Header Files" FILES MathFunctions.h)
source_group("Source Files" FILES  MathFunctions.cpp)


#================================表达式生成器配置不同编译选项=====================================
# define the symbol stating we are using the declspec(dllexport) when building on windows
# target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")
target_compile_definitions(MathFunctions PRIVATE $<$<CONFIG:Debug>:_DUBGU _TEST>)

#================================对库目标的依赖库，宏定义，库属性进行设置============================
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





#========================================安装指令====================================
#执行安装程序， 将外部库和程序安装到指定位置
set(installable_libs MathFunctions tutorial_compiler_flags)
if(TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()
install(TARGETS ${installable_libs}
        EXPORT MathFunctionsTargets
        DESTINATION Bin)
install(FILES MathFunctions.h DESTINATION include)



