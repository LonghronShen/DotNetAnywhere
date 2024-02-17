include(CheckIncludeFile)

check_include_file("sys/mman.h" HAVE_SYS_MMAN_H)
if(NOT HAVE_SYS_MMAN_H)
    # mman_win32
    FetchContent_Declare(mman_win32
        GIT_REPOSITORY https://github.com/boldowa/mman-win32.git
        GIT_TAG master)

    FetchContent_GetProperties(mman_win32)
    if(NOT mman_win32_POPULATED)
        FetchContent_Populate(mman_win32)
        add_subdirectory(${mman_win32_SOURCE_DIR} ${mman_win32_BINARY_DIR} EXCLUDE_FROM_ALL)

        target_include_directories(mman
            PUBLIC "${mman_win32_SOURCE_DIR}"
        )
    endif()
endif()


check_include_file("unistd.h" HAVE_UNISTD_H)
if(NOT HAVE_UNISTD_H)
    # unistd_h
    FetchContent_Declare(unistd_h
        GIT_REPOSITORY https://github.com/win32ports/unistd_h.git
        GIT_TAG master)

    FetchContent_GetProperties(unistd_h)
    if(NOT unistd_h_POPULATED)
        FetchContent_Populate(unistd_h)
        include_directories(SYSTEM ${unistd_h_SOURCE_DIR})
    endif()
endif()