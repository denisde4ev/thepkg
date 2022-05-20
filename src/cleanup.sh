#!/bin/sh
set -eu

cd "${0%/*}/.." || exit

for i in ./build/thepkg*; do
	rm -v "$(readlink -f "$i")"
done

rm -vr ./patches/thepkg-*
rm -vir ./test/*
