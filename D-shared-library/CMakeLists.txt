cmake_minimum_required(VERSION 3.5)


add_library(helloShared  SHARED  src/hello.cpp )

target_include_directories(helloShared  PUBLIC  ${PROJECT_SOURCE_DIR}/include)

add_executable(main   src/main.cpp)

target_link_libraries(main  PRIVATE  helloShared)

