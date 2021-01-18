#! /usr/bin/env bash
IFS=$'\n'
A=($(tr '.' '_' < "${1:-20.txt}"))
T=($(printf "%s\n" "${A[@]}" | grep -o "[0-9]*" ))
U=($(printf "%s\n" "${A[@]}" | grep -A1 T | grep -E "[_#]" ))
D=($(printf "%s\n" "${A[@]}" T | grep -B1 T | grep -E "[_#]" ))
IFS=$' T' L=($(printf "%s\n" "${A[@]}" | cut -c1 | tail +2 | tr -d '\n '))
IFS=$' :' R=($(printf "%s\n" "${A[@]}" | cut -c${#U[1]} | tail +2 | tr -d '\n '))
IFS=$'\n'
Ur=($(printf "%s\n" "${U[*]}" | rev))
Dr=($(printf "%s\n" "${D[*]}" | rev))
Lr=($(printf "%s\n" "${L[*]}" | rev))
Rr=($(printf "%s\n" "${R[*]}" | rev))
ENDS=() x=0
for i in "${!U[@]}"; do
     x=$(printf "%s\n" "${U[*]}" "${Ur[*]}" "${D[*]}" "${Dr[*]}" "${L[*]}" "${Lr[*]}" "${R[*]}" "${Rr[*]}" | grep -c -e "${U[i]}" -e "${Dr[i]}" -e "${Lr[i]}" -e "${R[i]}" )
    [ "$x" = 6 ] && ENDS+=("${T[i]}")
done
printf -v sum "*%s" "${ENDS[@]}"; sum=${sum:1}
echo "20A: $sum=$((sum))"
