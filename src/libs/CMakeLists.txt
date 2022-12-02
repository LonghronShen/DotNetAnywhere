project(dna-managed-libs C CXX)

macro(SUBDIRLIST result curdir)
  file(
    GLOB children
    RELATIVE ${curdir}
    ${curdir}/*)
  set(dirlist "")
  foreach(child ${children})
    if(IS_DIRECTORY ${curdir}/${child})
      list(APPEND dirlist ${child})
    endif()
  endforeach()
  set(${result} ${dirlist})
endmacro()

subdirlist(SUBDIRS ${CMAKE_CURRENT_LIST_DIR})
foreach(subdir ${SUBDIRS})
  add_msbuild_project("${subdir}" "${CMAKE_CURRENT_LIST_DIR}/${subdir}")
endforeach()
