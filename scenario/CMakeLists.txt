cmake_minimum_required(VERSION 3.10)
project(scenario)

set(CMAKE_CXX_STANDARD 11)

include_directories(.)

add_executable(scenario
        src/Entity/Gen.cpp
        src/Entity/Gen.h
        src/Loop.cpp
        src/Loop.h
        main.cpp
        Network/Network.cpp
        Network/Network.h)
