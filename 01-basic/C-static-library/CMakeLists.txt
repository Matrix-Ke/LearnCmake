cmake_minimum_required(VERSION 3.5)

project(HelloProject)

add_library(helloStatic  STATIC  src/Hello.cpp)

target_include_directories(helloStatic  PUBLIC  ${PROJECT_SOURCE_DIR}/include)

add_executable(HelloProject src/main.cpp)

target_link_libraries(HelloProject PRIVATE helloStatic)