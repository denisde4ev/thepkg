#!/bin/sh

# just extract pathes from thepkg.patch
# to separate file patches in ./patches/**/*.patch

set -u

cd "${0%/*}/.." || exit

[ -d ./patches ] || mkdir -v ./patches

# unset file
unset patch_name
unset hunk_header

##rediff-replace() {
##	# mv -vi ""
##	# TODO:!
##	echo TODOO >&2
##	exit 126
##}

#thepkg.patch
while :; do # label reading_patchfile
	IFS= read -r line || break # || break reading_patchfile

	while :; do # label parsing_patch_line


		case $line in
			[\-]*\[patch:*\]*) ;; # find first (removed line) (with patch init)
			@) hunk_header=$line; break;; # break parsing_patch_line
			*) break;; # break parsing_patch_line
		esac

		patch_name=${line#*\[patch:\ }
		patch_name=${patch_name%%\]*}

		case $line in
			[\-]*\[patch:" $patch_name"\]*) ;;
			*)
				printf %s\\n >&2 "ERROR matching patchname to line, patch_name=$patch_name, line=$line"
				break # break parsing_patch_line
			;;
		esac
		case $patch_name in
			["$IFS"]|'')
				printf %s\\n >&2 "ERROR matching empty patchname, patch_name=$patch_name, line=$line"
				break # break parsing_patch_line
			;;
		esac

		patch_file=./patches/"${patch_name}/${patch_name##*/}.patch"
		mkdir -pv "${patch_file%/*}" # note: patch_name might be nested dir


		{ # {writing to file} >"$patch_file"
			if [ -s "$patch_file" ]; then
				echo
			else
				printf %s\\n \
					"--- thepkg" \
					"+++ $patch_name" \
				;
			fi
			hunk_header=${hunk_header:-'@@ -0,0 +0,0 @@'}
			printf %s\\n \
				"$hunk_header" \
				"$line" \
			;
			while :; do
				IFS= read -r next_line || break 3 # break reading_patchfile
				case $next_line in
					[\-\+]*) printf %s\\n "$next_line";;
					*) break 2;; # break parsing_patch_line
				esac
			done
		} >"$patch_file"
		rediff thepkg.patch "$patch_file"

	done # end label parsing_patch_line

done < ./src/thepkg.patch # end label reading_patchfile
