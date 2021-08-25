#! /usr/bin/env bash
C=($(grep "^[0-9]" "${1:-22.txt}"))
N=${#C[@]}
A=(${C[@]:0:N/2})
B=(${C[@]:$N/2})

score() {
    local sum=0 S=("$@")
    for i in "${!S[@]}"; do ((sum+=S[i]*(N-i))); done
    echo $sum
}

# shellcheck disable=SC2128
while [[ -n "$A" && -n "$B" ]]; do
    if [[ $A -gt $B ]]; then A+=($A $B); else B+=($B $A); fi
    A=(${A[@]:1})
    B=(${B[@]:1})
    #((++round%500==0)) && echo "$round: ${#A[@]}/${#B[@]}"
done
printf "22A: "; score "${A[@]}" "${B[@]}"

r() {
  declare -A H
  local a=($1) b=($2) depth=$3
  # shellcheck disable=SC2128,SC2181
  while [[ -n "$a" && -n "$b" ]]; do
    if (( ++H[${a[*]}X${b[*]}] > 1)); then
        return 0
    elif [[ $a -lt ${#a[@]} && $b -lt ${#b[@]} ]];  then
        r "${a[*]:1:a}" "${b[*]:1:b}" $((depth+1))
    else
        [[ $a -gt $b ]]
    fi
    if [[ $? == 0 ]]; then a+=($a $b); else b+=($b $a); fi
    a=(${a[@]:1})
    b=(${b[@]:1})
    #((${#H[@]}%1000==0)) && echo "$depth:${#H[@]}: ${#a[@]}/${#b[@]}"
  done
  [[ $depth != 0 ]] && return ${#b[@]}
  printf "22B: "; score "${a[@]}" "${b[@]}"
}

r "${C[*]:0:N/2}" "${C[*]:N/2}" 0
