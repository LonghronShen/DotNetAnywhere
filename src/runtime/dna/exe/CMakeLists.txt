project(dna C CXX)

file(GLOB_RECURSE src
    ${CMAKE_CURRENT_LIST_DIR}/*.h
    ${CMAKE_CURRENT_LIST_DIR}/*.hpp

    ${CMAKE_CURRENT_LIST_DIR}/*.c
	${CMAKE_CURRENT_LIST_DIR}/*.cc
	${CMAKE_CURRENT_LIST_DIR}/*.cpp
)

# file(GLOB_RECURSE assets
# 	${CMAKE_CURRENT_LIST_DIR}/assets/*.*
# )

# =================================================================
add_executable(dna ${src})

target_include_directories(dna
    PUBLIC "${CMAKE_CURRENT_LIST_DIR}/include/public"
    PRIVATE "${CMAKE_CURRENT_LIST_DIR}/include/private"
)

target_link_libraries(dna
    PUBLIC dna::runtime
)

# foreach(res IN ITEMS ${assets})
# 	message(STATUS "Copying ${file} to ${CMAKE_BINARY_DIR} ...")
# 	get_filename_component(res_file_name ${res} NAME)
# 	configure_file(${res} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/assets/${res_file_name} COPYONLY)
# endforeach()
