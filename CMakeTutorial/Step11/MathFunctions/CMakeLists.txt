add_library(MathFunctions MathFunctions.cpp)

#interface： 暴露给外部需要使用这个库以这个头文件，但是该库cpp自身是不需要的额外inlcude的
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)
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

# define the symbol stating we are using the declspec(dllexport) when
# building on windows
target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")



#========================================安装指令====================================
#执行安装程序， 将外部库和程序安装到指定位置
# install rules
set(installable_libs MathFunctions)
if(TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()
install(TARGETS ${installable_libs} DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)





