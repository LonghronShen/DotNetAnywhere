find_package(Threads REQUIRED)

if(UNIX)
  find_package(libm REQUIRED)
  find_package(DL REQUIRED)
endif()

set(FETCHCONTENT_UPDATES_DISCONNECTED ON CACHE STRING "FETCHCONTENT_UPDATES_DISCONNECTED" FORCE)

include(FetchContent)
include(dotnet)

include(polyfills)

# cmrc
FetchContent_Declare(cmrc
    GIT_REPOSITORY https://github.com/vector-of-bool/cmrc.git
    GIT_TAG a64bea50c05594c8e7cf1f08e441bb9507742e2e)

FetchContent_GetProperties(cmrc)
if(NOT cmrc_POPULATED)
    FetchContent_Populate(cmrc)
    add_subdirectory(${cmrc_SOURCE_DIR} ${cmrc_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()


# nlohmann_json
FetchContent_Declare(json
  GIT_REPOSITORY https://github.com/ArthurSonzogni/nlohmann_json_cmake_fetchcontent
  GIT_TAG v3.10.4)

FetchContent_GetProperties(json)
if(NOT json_POPULATED)
  FetchContent_Populate(json)
  add_subdirectory(${json_SOURCE_DIR} ${json_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()


# freetype
set(FT_DISABLE_HARFBUZZ ON CACHE STRING "FT_DISABLE_HARFBUZZ" FORCE)

FetchContent_Declare(freetype
  GIT_REPOSITORY https://github.com/freetype/freetype.git
  GIT_TAG master)

FetchContent_GetProperties(freetype)
if(NOT freetype_POPULATED)
  FetchContent_Populate(freetype)
  add_subdirectory(${freetype_SOURCE_DIR} ${freetype_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()
