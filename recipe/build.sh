#!/bin/sh

mkdir build
cd build

cmake ${CMAKE_ARGS} -GNinja .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_TESTING=ON

cmake --build . --config Release
cmake --build . --config Release --target install
# Some tests disabled due to https://github.com/robotology/ycm/issues/382
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
ctest --output-on-failure -C Release -E "YCMBootstrap-not-use-system|YCMBootstrap-disable-find|RunCMake.IncludeUrl"
fi
