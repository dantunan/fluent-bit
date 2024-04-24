# Configures to build with Qt

if(CMAKE_SYSTEM_NAME STREQUAL QNX)
    set(CMAKE_PREFIX_PATH "C:/Qt5.12.3/qnx-aarch64le-qcc")
else()
    if(${CMAKE_EXE_LINKER_FLAGS} MATCHES "X86")
        set(CMAKE_PREFIX_PATH "C:/Qt/Qt5.11.2/5.11.2/msvc2015")
    else()
        set(CMAKE_PREFIX_PATH "C:/Qt/5.15.2/msvc2019_64")
    endif()
endif()
