#!/bin/bash
# Open an image in feh while allowing all other images in the directory to be
# viewed as well. Useful for file browsers.
# Source: https://wiki.archlinux.org/index.php/Feh#File_Browser_Image_Launcher

shopt -s nullglob

if [[ ! -f $1 ]]; then
    echo "$0: first argument is not a file" >&2
    exit 1
fi

file=$(basename -- "$1")
dir=$(dirname -- "$1")
arr=()
shift

cd -- "$dir"

frmt="*.jpg *.jpeg *.png *.bmp *.gif *.ico *.tif *.tiff "
frmtall=${frmt}${frmt^^}

for i in $frmtall; do
    [[ -f $i ]] || continue
    arr+=("$i")
    [[ $i == $file ]] && c=$((${#arr[@]} - 1))
done

exec feh --action ';gimp %f&' -S filename "$@" -- "${arr[@]:c}" "${arr[@]:0:c}"
