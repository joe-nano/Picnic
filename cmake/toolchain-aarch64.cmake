set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(triplet "${CMAKE_SYSTEM_PROCESSOR}-linux-gnu")

# compiler
SET(CMAKE_C_COMPILER   ${triplet}-gcc)
SET(CMAKE_CXX_COMPILER ${triplet}-g++)

# paths
SET(CMAKE_FIND_ROOT_PATH "/usr/${triplet}")
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# linker, etc
find_program(GCC_FULL_PATH ${triplet}-gcc)
if (NOT GCC_FULL_PATH)
  message(FATAL_ERROR "Cross-compiler ${triplet}-gcc not found")
endif ()
get_filename_component(GCC_DIR ${GCC_FULL_PATH} PATH)

SET(CMAKE_LINKER          ${GCC_DIR}/${triplet}-ld      CACHE FILEPATH "linker")
SET(CMAKE_ASM_COMPILER    ${GCC_DIR}/${triplet}-as      CACHE FILEPATH "assembler")
SET(CMAKE_OBJCOPY         ${GCC_DIR}/${triplet}-objcopy CACHE FILEPATH "objcopy")
SET(CMAKE_STRIP           ${GCC_DIR}/${triplet}-strip   CACHE FILEPATH "strip")
SET(CMAKE_CPP             ${GCC_DIR}/${triplet}-cpp     CACHE FILEPATH "cpp")

# pkg-config
find_program(PKG_CONFIG_EXECUTABLE ${triplet}-pkg-config)
