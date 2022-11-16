#!/bin/sh
set -eu
cd "${0%/*}" || exit

rm ../thepkg ../thepkg-allpatched


./thepkg.preprocess > ../thepkg

THEPKG__ALLPATCHED__=1 \
THEPKG_NOERR_STAT0=1 \
THEPKG_SUBDIR_PREFIX=1 \
THEPKG_ADDFROMTAR=1 \
THEPKG_THEPKGVER_ARG_PARSING=1 \
THEPKG_UPGRADE=1 \
THEPKG_METADATA_THEPKG_EXT=1 \
THEPKG_EXTENDED_VERBOSE=1 \
THEPKG_RMFAILED=1 \
THEPKG_KEEP_ETC=1 \
./thepkg.preprocess > ../thepkg-allpatched

chmod -v +x ../thepkg ../thepkg-allpatched
