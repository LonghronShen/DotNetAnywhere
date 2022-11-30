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

function(add_dotnet_core_project lib_name target_dir)
  file(GLOB_RECURSE subdir_src "${target_dir}/*.cs" "${target_dir}/*.csproj")

  add_custom_command(
      OUTPUT "${target_dir}/bin/${lib_name}.dll"
      COMMAND "${DOTNET_EXECUTABLE}" build -o ./bin/
      DEPENDS ${subdir_src}
      WORKING_DIRECTORY "${target_dir}/"
  )

  add_custom_command(
      OUTPUT "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${lib_name}.dll"
      COMMAND ${CMAKE_COMMAND} -E copy "${target_dir}/bin/${lib_name}.dll" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
      DEPENDS "${target_dir}/bin/${lib_name}.dll"
  )

  add_custom_target("managed_lib_${lib_name}" ALL DEPENDS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${lib_name}.dll")
endfunction()

function(add_msbuild_project lib_name target_dir)
  file(GLOB_RECURSE subdir_src "${target_dir}/*.cs" "${target_dir}/*.csproj")

  add_custom_command(
      OUTPUT "${target_dir}/bin/${lib_name}.dll"
      COMMAND "${MSBUILD_EXECUTABLE}" build /p:OutputPath=./bin/
      DEPENDS ${subdir_src}
      WORKING_DIRECTORY "${target_dir}/"
  )

  add_custom_command(
      OUTPUT "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${lib_name}.dll"
      COMMAND ${CMAKE_COMMAND} -E copy "${target_dir}/bin/${lib_name}.dll" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/"
      DEPENDS "${target_dir}/bin/${lib_name}.dll"
  )

  add_custom_target("managed_lib_${lib_name}" ALL DEPENDS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${lib_name}.dll")
endfunction()