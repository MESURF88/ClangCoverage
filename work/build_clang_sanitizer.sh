#!/bin/bash
echo "build project in debug mode"
cmake --build ./build ||
(cmake -GNinja -Bbuild -S . \
-D CMAKE_MAKE_PROGRAM=ninja \
-D CMAKE_BUILD_TYPE=Debug \
-D CMAKE_LINKER=llvm-linker \
-D CLANG_CODE_COVERAGE=ON && \
cmake --build ./build)