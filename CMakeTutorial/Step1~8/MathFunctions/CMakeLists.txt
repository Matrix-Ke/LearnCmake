# # #=========================添加系统自检======================
# # does this system provide the log and exp functions?
# include(CheckSymbolExists)
# check_symbol_exists(log "math.h" HAVE_LOG)
# check_symbol_exists(exp "math.h" HAVE_EXP)
# if(NOT (HAVE_LOG AND HAVE_EXP))
#     unset(HAVE_LOG CACHE)
#     unset(HAVE_EXP CACHE)
#     # set(CMAKE_REQUIRED_LIBRARIES "m") includes the math library， "m"就是math库
#     set(CMAKE_REQUIRED_LIBRARIES "m")
#     check_symbol_exists(log "math.h" HAVE_LOG)
#     check_symbol_exists(exp "math.h" HAVE_EXP)
#     if(HAVE_LOG AND HAVE_EXP)
#     target_link_libraries(MathFunctions PRIVATE m)
#   endif()
# endif()

# if(HAVE_LOG AND HAVE_EXP)
#   target_compile_definitions(MathFunctions PRIVATE "HAVE_LOG" "HAVE_EXP")
# endif()


add_executable(MakeTable  MakeTable.cpp)
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
    COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
    DEPENDS MakeTable
)


add_library(MathFunctions mysqrt.cpp  ${CMAKE_CURRENT_BINARY_DIR}/Table.h)

#interface： 暴露给外部需要使用这个库以这个头文件，但是该库cpp自身是不需要的额外inlcude的
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          PRIVATE ${CMAKE_CURRENT_BINARY_DIR}
)






#========================================安装指令====================================
#执行安装程序， 将外部库和程序安装到指定位置
install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
