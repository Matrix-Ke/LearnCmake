cmake_minimum_required(VERSION 3.15)
project(MatrixTutorial VERSION 1.0.0)


set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../Bin) #设置可执行文件的输出目录，目录后面扩展一层<Config>
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../Bin) #库文件的输出目录
#分别设置可执行文件的debug和relase输出路径 : CMAKE_RUNTIME_OUTPUT_DIRECTORY_<CONFIG>
#分别设置库文件的Debug和release输出路径： CMAKE_ARCHIVE_OUTPUT_DIRECTORY_<CONFIG>



# list(APPEND  CMAKE_MODULE_PATH   ${CMAKE_CURRENT_SOURCE_DIR})
# <package>_DIR。我们可以在调用cmake时将这个目录传给cmake。由于其优先级最高，
# 因此cmake会优先从该目录中寻找，这样我们就可以随心所欲的配置cmake使其找到我们希望它要找到的包
list(APPEND   CMAKE_PREFIX_PATH   ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
message(STATUS CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH})


find_package(MathFunctions)
if(MathFunctions_FOUND)
  message(STATUS package= MathFunctions)
else()
  message(FATAL_ERROR "MathFunctions package fucking error")
endif(MathFunctions_FOUND)



add_executable(MatrixTutorial  ./tutorial.cpp )


# add_library(MathFunctions  SHARED IMPORTED GLOBAL)
target_link_libraries(MatrixTutorial PRIVATE MathFunctions)

target_link_directories(MatrixTutorial PRIVATE ${PROJECT_SOURCE_DIR}/Lib/)
set_target_properties(MathFunctions PROPERTIES IMPORTED_IMPLIB MathFunctions.lib )
set_target_properties(MathFunctions PROPERTIES IMPORTED_LOCATION   ${PROJECT_SOURCE_DIR}/Bin )




















