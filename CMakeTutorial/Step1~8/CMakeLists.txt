cmake_minimum_required(VERSION 3.10)

project(MatrixTutorial VERSION 1.0.0 )

#设置c+++ standard 
set(CMAKE_CXX_STANDARD  11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

#默认config结果保存到build文件夹中，默认TutorialConfig.h将生成到PROJECT_BINARY_DIR文件夹中
message(STATUS configPath= ${${PROJECT_BINARY_DIR}})
configure_file(TutorialConfig.h.in  TutorialConfig.h)

option(USE_MYMATH "Use tutorial provided math implementation" ON)
if(USE_MYMATH)
#添加子文件夹
    add_subdirectory(MathFunctions)
    list(APPEND  EXTRA_LIBS MathFunctions)
    #因为外部库使用了inteface 所以直接包含库就行了，无需额外包含库的头文件
    # list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunctions")
endif()



add_executable(MatrixTutorial  tutorial.cpp)
target_link_libraries(MatrixTutorial PUBLIC 
    ${EXTRA_LIBS}
)



target_include_directories(MatrixTutorial PUBLIC  
    "${PROJECT_BINARY_DIR}"
    #因为外部库使用了inteface,无需额外包含库的头文件
    # "${EXTRA_INCLUDES}"
)


#=================================安装程序=================================
# 默认生成到PROJECT_BINARY_DIR文件夹中, 也可以指定prefix 类如： 
# cmake --install . --prefix "/home/myuser/installdir"
install(TARGETS MatrixTutorial  DESTINATION Bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h" DESTINATION include)



# =================================开启测试程序=============================
# # enable testing Replace with include(CTest) enable dashboard scripting
# enable_testing()
include(CTest)
# does the application run
add_test(NAME Runs COMMAND MatrixTutorial 25)

# does the usage message work?
add_test(NAME Usage COMMAND MatrixTutorial)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )

# define a function to simplify adding tests
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()

# do a bunch of result based tests
do_test(MatrixTutorial 4 "4 is 2")
do_test(MatrixTutorial 9 "9 is 3")
do_test(MatrixTutorial 5 "5 is 2.236")
do_test(MatrixTutorial 7 "7 is 2.645")
do_test(MatrixTutorial 25 "25 is 5")
do_test(MatrixTutorial -25 "-25 is (-nan|nan|0)")
do_test(MatrixTutorial 0.0001 "0.0001 is 0.01")

#======================================执行安装程序================================
include(InstallRequiredSystemLibraries)
set(cpack_source_file_license "${CMAKE_CURRENT_SOURCE_DIR}/License.txt" )
set(cpack_pacage_version__major "${Tutorial_VERSION_MAJOR}")
set(cpack_package_version_minor "${Tutorial_VERSION_MINOR}")
#The CPACK_SOURCE_GENERATOR variable selects a file format for the source package
set(CPACK_SOURCE_GENERATOR  "TGZ")
include(CPack)
































