# Find dotnet cli
find_program(DOTNET_EXECUTABLE 
  NAMES dotnet
  HINTS /usr/local/bin ~/.dotnet
)
if(NOT DOTNET_EXECUTABLE)
  message(FATAL_ERROR "Check for dotnet Program: not found")
else()
  message(STATUS "Found dotnet Program: ${DOTNET_EXECUTABLE}")
endif()

# Find dotnet cli
find_program(MSBUILD_EXECUTABLE 
  NAMES msbuild xbuild
)
if(NOT MSBUILD_EXECUTABLE)
  message(FATAL_ERROR "Check for msbuild Program: not found")
else()
  message(STATUS "Found dotnet Program: ${MSBUILD_EXECUTABLE}")
endif()