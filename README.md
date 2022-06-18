# THEPKG
simple patchable package manager powered by tar

## Example usage:
``` shell
$ cd ./package-making/package-hello-world
$ ./package-hello-wold.sh
$ thepkg add hello-world < ./hello-wold.tar
 -> Extracting the pkg 'hello-world'...
created directory: '/var/db/thepkg/hello-world'
bin/hello-wold
$ hello-world
Hello, World!
$ thepkg del hello-world
 -> Removing the pkg 'hello-world'...
removed 'bin/hello-wold'
removed '/var/db/thepkg/hello-world/manifest'
removed '/var/db/thepkg/hello-world/version'
rmdir: removing directory, '/var/db/thepkg/hello-world'
```

## Usage message:
```
$ thepkg --help
Usage: thepkg <add|del> <thepkgname>
reads tar format package from stdin
$ 
$ ./thepkg-allpatched --help # (for now with many todo, I'm still working on it)
Usage: thepkg-allpatched <add|del> </path/to/thepkgname.tar.qz | thepkgname.tar | thepkgname>
reads tar format package from stdin

[patches applyed: {TODO: for now not separated per package path for help info}
  (not tested)
  [thepkg-addfromtar]
    install from tar and use (tar -a) autodetect if its for example '.tar.gz'.
    thepkgname may be: </path/to/thepkgname.tar.qz | thepkgname.tar | thepkgname>

  (not done)
  [thepkg-thepkgver-arg-parsing]
    thepkgname may be <thepkgname@v1.0.0>

  (not done)
  [thepkg-subdir-prefix]
    use env var $THEPKG_SUBDIR_PREFIX as $THEPKG_PREFIX sub dir,
    but stil write it to $THEPKG_DBPATH/manifest file

  (internal)
  (not done at all)
  [thepkg-args-parsing-loop]
    prepare code for args parsing patches

  (requires: thepkg-args-parsing-loop)
  (not done at all)
  [thepkg-metadata]
    when thepkgname is in (*.thepkg.*|*.thepkg) or --metadata used. then metadata is read from the start of the file

  (not done at all)
  [thepkg-keep-etc]
    keep files from /env, exept when --nosave is specifyed

  (not done at all)
  [thepkg-metadata-thepkg-ext]
    parse '*.thepkg' file that contains metadata about the package
    used only when extention is (*.thepkg) or when --thepkg-metadata specifyed
    .thepkg file is tar file with prepended metadata prepended data

  (not done at all)
  [thepkg-upgrade]
    upgrade package

  (done)
  (internal)
  [thepkg-noerr-stat0]
    err fn to not exit when $2=0

  (done)
  (requires: thepkg-noerr-stat0)
  [thepkg-extended-verbose]
    (1 for now!) print longer messages

  (writing ! -> testing )
  [thepkg-rmfailed]
     when removing files failed,
     then keep manifest.rmfailed
```
