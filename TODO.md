# THEPKG TODOs:

--

if THEPKG_PREFIX is defined and not empty
when removing thepkg chek if any of the lines in manifest starts with '/'
and if yes exit 1 / exit 3

--


implement safe remove pkg: when removing files write succussfully removed to /var/db/thepkg/MyPkg/manifest-removed and leave failed to /var/db/thepkg/MyPkg/manifest
consider using `/var/db/thepkg/MyPkg/lock` to stop 2 process operating on same pkg