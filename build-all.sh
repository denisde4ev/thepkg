#!/bin/sh

cd "${0%/*}" || exit

./extra/thepkg-pacapt/build.sh
./src/build.sh
