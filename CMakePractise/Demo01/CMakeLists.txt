cmake_minimum_required(VERSION 3.15)
project(MatrixTutorial VERSION 1.0.0)


set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/Bin) #设置可执行文件的输出目录，目录后面扩展一层<Config>
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/Bin) #库文件的输出目录
#分别设置可执行文件的debug和relase输出路径 : CMAKE_RUNTIME_OUTPUT_DIRECTORY_<CONFIG>
#分别设置库文件的Debug和release输出路径： CMAKE_ARCHIVE_OUTPUT_DIRECTORY_<CONFIG>

add_executable(CmakeTutorial  tutorial.cpp)

target_link_directories(CmakeTutorial   PRIVATE lib)

target_include_directories(CmakeTutorial PRIVATE include)

target_link_libraries(CmakeTutorial  PRIVATE  MathFunctions.lib)
















