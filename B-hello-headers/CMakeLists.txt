cmake_minimum_required(VERSION 3.5)

set(hello_headers "HelloCmake")

project(${hello_headers})


set( SOURCES  src/main.cpp  src/Hello.cpp )

add_executable( ${hello_headers}  ${SOURCES})

# target_include_directories(${ProjectName} PRIVATE  ${PROJECT_SOURCE_DIR}/include )
target_include_directories(${hello_headers}   PRIVATE  ${PROJECT_SOURCE_DIR}/include )



