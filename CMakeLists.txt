cmake_minimum_required(VERSION 3.10)
set (CMAKE_CXX_STANDARD 20)
project(PROJECT_NAME_HERE)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(PACKAGE_HERE CONFIG REQUIRED)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

file(GLOB_RECURSE headers "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp")
file(GLOB_RECURSE sources "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

add_executable(${PROJECT_NAME} ${sources} ${headers})

target_link_libraries(${PROJECT_NAME}PRIVATE PACKAGE_HERE)

