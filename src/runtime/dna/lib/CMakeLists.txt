project(dna C CXX)

file(GLOB_RECURSE src
    ${CMAKE_CURRENT_LIST_DIR}/*.h
    ${CMAKE_CURRENT_LIST_DIR}/*.hpp

    ${CMAKE_CURRENT_LIST_DIR}/*.c
	${CMAKE_CURRENT_LIST_DIR}/*.cc
	${CMAKE_CURRENT_LIST_DIR}/*.cpp

	${CMAKE_CURRENT_LIST_DIR}/*.def
)

file(GLOB_RECURSE asm_src
    ${CMAKE_CURRENT_LIST_DIR}/*.asm
)

file(GLOB_RECURSE public_headers
    ${CMAKE_CURRENT_LIST_DIR}/include/public/*.h
    ${CMAKE_CURRENT_LIST_DIR}/include/public/*.hpp
)

# =================================================================
if(MSVC)
    if(${CMAKE_GENERATOR_PLATFORM} MATCHES "ARM")
        file(GLOB_RECURSE asm_src
            ${CMAKE_CURRENT_LIST_DIR}/*.arm64.asm
        )
        set_source_files_properties(
            ${asm_src}
            PROPERTIES
                COMPILE_DEFINITIONS "_M_ARM64")
    else()
        enable_language(ASM_MASM)
        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            file(GLOB_RECURSE asm_src
                ${CMAKE_CURRENT_LIST_DIR}/*.amd64.asm
            )
            set_source_files_properties(
                ${asm_src}
                PROPERTIES
                    COMPILE_DEFINITIONS "_M_X64")
        else()
            file(GLOB_RECURSE asm_src
                ${CMAKE_CURRENT_LIST_DIR}/*.x86.asm
            )
            set_source_files_properties(
                ${asm_src}
                PROPERTIES
                    COMPILE_DEFINITIONS "_M_X86"
                    COMPILE_FLAGS "/safeseh")
        endif()
        set_source_files_properties(${asm_src} PROPERTIES LANGUAGE ASM_MASM)
    endif()
endif()

add_library(dna-lib
    STATIC ${asm_src} ${src}
)

add_library(dna::runtime ALIAS dna-lib)

target_link_libraries(dna-lib
    PUBLIC dna::graph
    PUBLIC ${CMAKE_DL_LIBS}
    PUBLIC ${LIBM_LIBRARIES}
)

if(WIN32)
    target_link_libraries(dna-lib
        PUBLIC wsock32
        PUBLIC ws2_32
    )
endif()

target_include_directories(dna-lib
    PUBLIC "${CMAKE_CURRENT_LIST_DIR}/include/public"
    PRIVATE "${CMAKE_CURRENT_LIST_DIR}/include/private"
)
