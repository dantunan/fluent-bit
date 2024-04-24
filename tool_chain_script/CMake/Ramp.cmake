if(CMAKE_SYSTEM_NAME STREQUAL QNX)
    set(RAMP_CMAKE_OS Qnx)
else()
    set(RAMP_CMAKE_OS Win)
endif()

function(MakeWarningAsError TARGET)
    if(RAMP_CMAKE_MODEL_ANIMATION)
        # Rhapsody\8.1.5\Share\LangCpp\omcom\om2str.h:164:
        # warning: C4996: 'sprintf': This function or variable may be unsafe. Consider using sprintf_s instead.
        target_compile_options(
            ${TARGET}
            PUBLIC
            -wd4996)
    else()
        # Make all warnings as errors
        if(MSVC)
            target_compile_options(
                ${TARGET}
                PRIVATE
                /WX)

        else()
            target_compile_options(
                ${TARGET}
                PRIVATE
                -Werror)
        endif()
    endif()
endfunction()
