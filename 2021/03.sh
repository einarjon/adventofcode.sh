#! /usr/bin/env bash
nextchar() {
    local -n most=$1 least=$2 in=$3
    local all; all=$(printf "%s\n" "${in[@]}" | cut -c"$4" | tr -d '\n' )
    local ones=${all//0} zeros=${all//1}
    if (( ${#ones} >= ${#zeros} )); then
        most+=1; least+=0
    else  most+=0; least+=1; fi
}
A=($(< "${1:-3.txt}"))
idx=(${!A[@]}) len=${#A[0]} g="" e=""
for i in "${idx[@]:1:$len}"; do
   nextchar g e A "$i"
done
echo "3A: $g*$e = $(($((2#$g))*$((2#$e))))"
O=(${A[@]}) C=(${A[@]}) c=${e:0:1} o=${g:0:1}
for i in "${idx[@]:2:len}"; do
    O=($(printf "%s\n" "${O[@]}" | grep "^$o"))
    (( ${#O[@]} <= 1 )) && break
    nextchar o _ O "$i"
done
for i in "${idx[@]:2:len}"; do
    C=($(printf "%s\n" "${C[@]}" | grep "^$c"))
    (( ${#C[@]} <= 1 )) && break
    nextchar _ c C "$i"
done
# shellcheck disable=SC2128
echo "3B: $O*$C = $(($((2#$O))*$((2#$C))))"
