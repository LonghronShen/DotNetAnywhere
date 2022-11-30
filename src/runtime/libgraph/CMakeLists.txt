project(graph C CXX)

file(GLOB_RECURSE src
    ${CMAKE_CURRENT_LIST_DIR}/*.h
    ${CMAKE_CURRENT_LIST_DIR}/*.hpp

    ${CMAKE_CURRENT_LIST_DIR}/*.c
	${CMAKE_CURRENT_LIST_DIR}/*.cc
	${CMAKE_CURRENT_LIST_DIR}/*.cpp

	${CMAKE_CURRENT_LIST_DIR}/*.def
)

file(GLOB_RECURSE public_headers
    ${CMAKE_CURRENT_LIST_DIR}/include/public/*.h
    ${CMAKE_CURRENT_LIST_DIR}/include/public/*.hpp
)

file(GLOB fonts
	${CMAKE_CURRENT_LIST_DIR}/fonts/*.*
)

# =================================================================
add_library(graph
    SHARED ${src}
)

add_library(dna::graph ALIAS graph)

target_include_directories(graph
    PUBLIC "${CMAKE_CURRENT_LIST_DIR}/include/public"
    PRIVATE "${CMAKE_CURRENT_LIST_DIR}/include/private"
)

target_link_libraries(graph
    PUBLIC freetype
)

foreach(res IN ITEMS ${fonts})
	message(STATUS "Copying ${file} to ${CMAKE_BINARY_DIR} ...")
	get_filename_component(res_file_name ${res} NAME)
	configure_file(${res} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/fonts/${res_file_name} COPYONLY)
endforeach()
