cmake_minimum_required(VERSION 3.15)
project(MatrixTutorial VERSION 1.0.0)


set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/Bin) #设置可执行文件的输出目录，目录后面扩展一层<Config>
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/Bin) #库文件的输出目录
#分别设置可执行文件的debug和relase输出路径 : CMAKE_RUNTIME_OUTPUT_DIRECTORY_<CONFIG>
#分别设置库文件的Debug和release输出路径： CMAKE_ARCHIVE_OUTPUT_DIRECTORY_<CONFIG>

# FetchContent_MakeAvailable was not added until CMake 3.14
if(${CMAKE_VERSION} VERSION_LESS 3.14)
    include(add_FetchContent_MakeAvailable.cmake)
endif()


# 添加第三方依赖包
include(FetchContent)
Fetchcontent_declare(
    	spdlog	#库名字
        GIT_REPOSITORY  git@github.com:gabime/spdlog.git	# 仓库地址
        # GIT_TAG v1.x # 库版本
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/_deps/spdlog # 指定库下载地址
				    )
FetchContent_MakeAvailable(spdlog)


add_executable(CmakeTutorial  tutorial.cpp)
target_link_directories(CmakeTutorial   PRIVATE lib)
target_include_directories(CmakeTutorial PRIVATE include)
target_link_libraries(CmakeTutorial  PRIVATE  MathFunctions.lib)


target_link_libraries(CmakeTutorial PUBLIC spdlog)
















