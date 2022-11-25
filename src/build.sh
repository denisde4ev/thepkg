#!/bin/sh
set -eu
cd "${0%/*}" || exit

rm -f ../thepkg ../thepkg-allpatched


./thepkg.preprocess > ../thepkg

THEPKGCONFIG__ALLPATCHED__=1 \
THEPKGCONFIG_NOERR_STAT0=1 \
THEPKGCONFIG_SUBDIR_PREFIX=1 \
THEPKGCONFIG_ADDFROMTAR=1 \
THEPKGCONFIG_THEPKGVER_ARG_PARSING=1 \
THEPKGCONFIG_UPGRADE=1 \
THEPKGCONFIG_METADATA_THEPKG_EXT=1 \
THEPKGCONFIG_EXTENDED_VERBOSE=1 \
THEPKGCONFIG_RMFAILED=1 \
THEPKGCONFIG_KEEP_ETC=1 \
./thepkg.preprocess > ../thepkg-allpatched

chmod +x ../thepkg ../thepkg-allpatched
