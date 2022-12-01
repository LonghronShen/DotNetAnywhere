function(find_program_ex)
  set(options REQUIRED)
  set(oneValueArgs NAME VAR)
  set(multiValueArgs NAMES HINTS)
  cmake_parse_arguments(FIND_PROGRAM_OPTIONS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  message(STATUS "Checking for '${FIND_PROGRAM_OPTIONS_NAME}' ...")
  find_program(FIND_PROGRAM_OPTIONS_VAR
    NAMES ${NAMES}
    HINTS ${HINTS}
  )
  if(NOT ${FIND_PROGRAM_OPTIONS_VAR})
    if(NOT FIND_PROGRAM_OPTIONS_REQUIRED)
      message(STATUS "Check for '${FIND_PROGRAM_OPTIONS_NAME}': not found")
    else()
      message(FATAL_ERROR "Check for '${FIND_PROGRAM_OPTIONS_NAME}': not found")
    endif()
  else()
    message(STATUS "Found program '${FIND_PROGRAM_OPTIONS_NAME}': ${${FIND_PROGRAM_OPTIONS_VAR}}")
  endif()
endfunction()

# Find dotnet cli
find_program_ex(
  NAME "dotnet"
  VAR DOTNET_EXECUTABLE
  NAMES dotnet
  HINTS /usr/local/bin ~/.dotnet
  REQUIRED
)

# Find msbuild cli
find_program_ex(
  NAME "msbuild"
  VAR MSBUILD_EXECUTABLE
  NAMES msbuild xbuild
)

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