#!/bin/sh

cd "${0%/*}/.." || exit

# todo: add the dir 'bin/' as in tar owner
tar -cvf ./package-making/thepkg.tar \
	--transform="s|thepkg|bin/thepkg|" --owner=root --group=root --mode=755 \
	./thepkg \
;
