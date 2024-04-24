cmake_minimum_required(VERSION 3.14.7)

# C++ Language Standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Enable all warnings
if(MSVC)
    add_compile_options(/Wall)
else()
    add_compile_options(-Wall)
    add_compile_options(-Wextra)
    add_compile_options(-pedantic)
endif()

option(APP_WARNINGS_AS_ERROR "Treat warnings as errors" ON)

if(APP_WARNINGS_AS_ERROR==ON)
    # Make all warnings as errors
    if(MSVC)
        add_compile_options(/WX)
    else()
        add_compile_options(-Werror)
    endif()
endif()
