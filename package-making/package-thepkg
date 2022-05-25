#!/bin/sh

cd "${0%/*}" || exit

tar -cvf ./thepkg.tar --transform="s|thepkg|bin/thepkg|" --owner=root --group=root --mode=755 thepkg
