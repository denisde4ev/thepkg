#!/bin/sh

# curl -L https://github.com/denisde4ev/thepkg/raw/master/thepkg-install.sh | THEPKG_PREFIX=/ THEPKG_DBPATH=/var/db/thepkg sh -x
# wget -O- https://github.com/denisde4ev/thepkg/raw/master/thepkg-install.sh | THEPKG_PREFIX=/ THEPKG_DBPATH=/var/db/thepkg sh -x

(
set -eu

: "${THEPKG_PREFIX:?}"
: "${THEPKG_DBPATH:?}"

mkdir -pv "${THEPKG_PREFIX}/bin"
mkdir -pv "${THEPKG_DBPATH}/thepkg"


curl -L https://github.com/denisde4ev/thepkg/raw/master/thepkg > "${THEPKG_PREFIX}/bin/thepkg"
chmod 755 "${THEPKG_PREFIX}/bin/thepkg"

# todo: patch the prefis and dbpath of thepkg
patch --forward --strip=1 "${THEPKG_PREFIX}/bin/thepkg" << EOF
--- thepkg.old	2022-05-01
+++ thepkg.new	2022-05-01
@@ -4,2 +4,2 @@
-: "\${THEPKG_PREFIX:=./opt}"
-: "\${THEPKG_DBPATH:=\$THEPKG_PREFIX/../var/db/thepkg}"
+: "\${THEPKG_PREFIX:="$THEPKG_PREFIX"}"
+: "\${THEPKG_DBPATH:="$THEPKG_DBPATH"}"
EOF

printf %s\\n "${THEPKG_PREFIX}/bin/thepkg" >> "${THEPKG_DBPATH}/thepkg/manifest"
)
