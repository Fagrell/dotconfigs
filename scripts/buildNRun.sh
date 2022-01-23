#!/bin/sh

cmake --build $2 --target $3 -- -j$1 && $(find $2 -name $3)
