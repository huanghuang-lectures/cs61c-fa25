if(NOT CMAKE_PROJECT_NAME STREQUAL "cs61c_fa25")
    cmake_minimum_required(VERSION 3.10)
    project(proj1_snake C)
    set(CMAKE_C_STANDARD 99)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wno-unused-function -Wconversion -g")
endif()

# Include directories
include_directories(src)

# Source files
set(SNAKE_UTILS_SRC
    src/snake_utils.c
    src/snake_utils.h
)

set(GAME_SRC
    src/game.c
    src/game.h
)

set(ASSERTS_SRC
    src/asserts.c
    src/asserts.h
)

# Snake executable
add_executable(snake
    src/snake.c
    ${SNAKE_UTILS_SRC}
    ${GAME_SRC}
)

# Interactive Snake executable
add_executable(interactive-snake
    src/interactive_snake.c
    ${SNAKE_UTILS_SRC}
    ${GAME_SRC}
)
target_link_libraries(interactive-snake pthread)

# Unit Tests executable
# Note: unit_tests.c includes game.c directly, so we don't add GAME_SRC here
add_executable(unit-tests
    src/unit_tests.c
    ${SNAKE_UTILS_SRC}
    ${ASSERTS_SRC}
)

# Custom Tests executable
# Note: custom_tests.c includes game.c directly, so we don't add GAME_SRC here
add_executable(custom-tests
    src/custom_tests.c
    ${SNAKE_UTILS_SRC}
    ${ASSERTS_SRC}
)

# Add custom target for running tests
add_custom_target(run-unit-tests
    COMMAND unit-tests
    DEPENDS unit-tests
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
)

add_custom_target(run-integration-tests
    COMMAND make run-integration-tests
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
)

add_custom_target(clean-all
    COMMAND make clean
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
)
