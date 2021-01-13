#! /usr/bin/env bash
C=($(grep ^[0-9] ${1:-22.txt}))
A=(${C[@]:0:${#C[@]}/2})
B=(${C[@]:${#C[@]}/2})

score() {
    local sum=0 S=($*)
    for i in ${!S[@]}; do ((sum+=S[i]*(50-i))); done
    echo $sum
}

round=0
while [[ ${#A[@]} != 0 && ${#B[@]} != 0 ]]; do
    if [[ $A -gt $B ]]; then A+=($A $B); else B+=($B $A); fi
    A=(${A[@]:1})
    B=(${B[@]:1})
    #((++round%500==0)) && echo "$round: ${#A[@]}/${#B[@]}"
done
echo "22A: $(score ${A[*]} ${B[*]})"

r() {
  local X="$*"
  declare -A H
  local a=(${X/ X*}) b=(${X/*X }) k=0 hash
  while [[ ${#a[@]} != 0 && ${#b[@]} != 0 ]]; do
    hash=${a[*]}X${b[*]}
    hash=${hash// /_}
    if [[ -n "${H[$hash]}" ]]; then
        return 0
    elif [[ $a -lt ${#a[@]} && $b -lt ${#b[@]} ]];  then
        r "${a[*]:1:a}" X "${b[*]:1:b}"
    else
        [[ $a -gt $b ]]
    fi
    if [[ $? == 0 ]]; then a+=($a $b); else b+=($b $a); fi
    H[$hash]=1
    a=(${a[@]:1})
    b=(${b[@]:1})
    #((${#H[@]}%1000==0)) && echo "$round:${#H[@]}: ${#a[@]}/${#b[@]}"
  done
  ((${#a[*]}+${#b[*]} == 50)) && echo "22B: $(score ${a[*]} ${b[*]})"
  return ${#b[@]}
}

A=(${C[@]:0:${#C[@]}/2})
B=(${C[@]:${#C[@]}/2})
r "${A[*]}" X "${B[*]}"
