#!/bin/sh

cd "${0%/*}" || exit
#rm ./thepkg-pacapt
pp ./src/thepkg-pacapt.preprocess > ./thepkg-pacapt
chmod +x ./thepkg-pacapt
