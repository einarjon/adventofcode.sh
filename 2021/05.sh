#!/usr/bin/env bash
input=${1:-5.txt}
swap(){
    local -n _x=$1 _y=$2
    local tmp=$_x; _x=$_y; _y=$tmp
}
IFS=$' ,\n'; ANS=0; ANS2=0; declare -Ai C=() D=()
while read -r x y _ X Y; do
    if (( x == X )); then
        (( y > Y )) && swap y Y
        while ((y<=Y)); do C[$x.$y]+=1; ((y++));done
    elif (( y == Y )); then
        (( x > X )) && swap x X
        while ((x<=X)); do C[$x.$y]+=1; ((x++));done
    elif (( (X-x) == (Y-y) || (X-x) == -(Y-y) )); then
        (( x > X )) && swap x X && swap y Y
        if (( y > Y )); then i=-1; else i=1; fi
        while ((x<=X)); do D[$x.$y]+=1; ((x++,y+=i));done
    fi
done < "$input"
ANS=(${C[@]//1}) # Lazy count. Fails if there are 11 crossings
echo "5A: ${#ANS[@]}"
for i in "${!C[@]}"; do  D[$i]+=${C[$i]}; done
ANS2=(${D[@]//1})
echo "5B: ${#ANS2[@]}"
