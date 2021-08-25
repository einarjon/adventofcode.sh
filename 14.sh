#! /usr/bin/env bash
IFS=$'\n'
A=($(< "${1:-14.txt}"))
declare -a mem mem2
for i in "${A[@]}"; do
    case $i in
        mask*) y=${i/*= }; o=$((2#${y//X/0})); z=$((2#${y//X/1}));;
        mem*)  y=${i/*= }; printf -v "${i/ =*}" "%s" $(((y&z)|o));;
    esac
done
printf -v sum "+%s" "${mem[@]}"
echo "14A: $((sum))"

r() {
    local x=${2/X/0}
    if [ "$x" = "$2" ]; then
        mem2[$1|(2#$x)]=$3
    else
        r "$1" "$x" "$3"
        r "$1" "${2/X/1}" "$3"
    fi
}

IFS=$' []=\n'
while read -r i y _ v; do
   case "$i" in
       mask*) o=$((2#${y//X/0})); m=${y//1/0}; z=$((~2#${m//X/1}));;
       mem*)  r $(((y&z)|o)) "$m" "$v";;
   esac
done < "${1:-14.txt}"
printf -v sum "+%s" "${mem2[@]}"
echo "14B: $((sum))"
