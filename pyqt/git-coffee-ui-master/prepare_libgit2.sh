#!/bin/bash

git submodule init libgit2
git submodule update libgit2
cd libgit2
mkdir build
cd build
cmake -DBUILD_CLAR=OFF -DBUILD_EXAMPLES=OFF -DTHREADSAFE=ON ..
cmake --build .
