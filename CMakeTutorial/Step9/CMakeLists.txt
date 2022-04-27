cmake_minimum_required(VERSION 3.10)

project(MatrixTutorial VERSION 1.0.0 )

#设置c+++ standard 
set(CMAKE_CXX_STANDARD  11)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)


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
































