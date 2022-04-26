cmake_minimum_required(VERSION 3.5)

project(cmake_examples_install)

############################################################
# Create a library
############################################################

#Generate the shared library from the library sources
add_library(cmake_examples_inst SHARED
    src/Hello.cpp
)

target_include_directories(cmake_examples_inst
    PUBLIC 
        ${PROJECT_SOURCE_DIR}/include
)

############################################################
# Create an executable
############################################################

# Add an executable with the above sources
add_executable(cmake_examples_inst_bin
    src/main.cpp
)

# link the new hello_library target with the hello_binary target
target_link_libraries( cmake_examples_inst_bin
    PRIVATE 
        cmake_examples_inst
)

############################################################
# Install
############################################################

# Binaries
install (TARGETS cmake_examples_inst_bin
    DESTINATION bin)

# Library
# Note: may not work on windows
install (TARGETS cmake_examples_inst
    LIBRARY DESTINATION lib)

# Header files
install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/ 
    DESTINATION include)

# Config
install (FILES cmake-examples.conf
    DESTINATION etc)


# message(STATUS CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR})


# add_library(testLib  SHARED  ./src/Hello.cpp)

# target_include_directories(testLib  PUBLIC   ${CMAKE_SOURCE_DIR}/include)


# add_executable(mainExec  src/main.cpp)

# target_link_libraries(mainExec  PRIVATE testLib)


# install(TARGETS mainExec testLib
#     LIBRARY DESTINATION ${CMAKE_BINARY_DIR}
#     RUNTIME DESTINATION ${CMAKE_BINARY_DIR}
# )