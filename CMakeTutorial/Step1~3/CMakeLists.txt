cmake_minimum_required(VERSION 3.10)

project(MatrixTutorial VERSION 1.0.0 )

#设置c+++ standard 
set(CMAKE_CXX_STANDARD  11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)


option(USE_MYMATH "Use tutorial provided math implementation" ON)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file(TutorialConfig.h.in TutorialConfig.h)

#默认config结果保存到build文件夹中，to the source code dir PROJECT_BINARY_DIR
message(STATUS configPath= ${Tutorial_VERSION_MAJOR})
configure_file(TutorialConfig.h.in  TutorialConfig.h)

if(USE_MYMATH)
#添加子文件夹
    add_subdirectory(MathFunctions)
    list(APPEND  EXTRA_LIBS MathFunctions)
    list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunctions")
endif()



add_executable(MatrixTutorial  tutorial.cpp)
target_link_libraries(MatrixTutorial PUBLIC ${EXTRA_LIBS})



target_include_directories(MatrixTutorial PUBLIC  
    "${PROJECT_BINARY_DIR}"
    "${EXTRA_INCLUDES}"
)





