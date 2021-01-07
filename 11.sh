#! /usr/bin/env bash
A=($(tr "L" "X" < ${1:-11.txt}))
B=(.${A//?/.}.); for i in "${A[@]}"; do B+=(.$i.); done; B+=($B); C=("${B[@]}");
J=$(seq 1 ${#A}); I=$(seq 1 ${#A[@]}); change=($I); round=0
while [ ${#change} != 0 ]; do
    change=(); l=
    for i in $I; do
        for j in $J; do
            x=${B[i]:$j:1};
            if [[ "$x" == "L" || "$x" == "X" ]]; then
                s="${B[i-1]:$((j-1)):3}${B[i]:$((j-1)):1}${B[i]:$((j+1)):1}${B[i+1]:$((j-1)):3}";
                s=${s//[L.]/}
                if [[ ${#s} == 0 ]]; then x=X; elif [[ ${#s} -ge 4 ]]; then x=L; fi;  k=$((k+1))
            fi;
            l+=$x;
        done
        [ "${B[i]}" != .$l. ] && change+=($((i-1)) $i $((i+1)))
        C[i]=.$l.; l=
    done
    B=("${C[@]}")
    I=$(printf "%s\n" ${change[@]} |sort -u)
    [ $((++round)) = 1 ] && B=("${C[@]//X/x}")
    #[ $((round%10)) = 0 ] && echo "$round: $((${#change[@]}/3))"
done
ans="${B[*]}"; ans=${ans//[ L.]}
echo "11A: ${#ans}"

#A=($(< ${1:-11.txt}))
B=(L${A//?/L}L); for i in "${A[@]}"; do B+=(L${i}L); done; B+=($B)
J=$(seq ${#A}); I=$(seq ${#A[@]}); change=1; round=0
while [ ${#change} != 0 ]; do
    change=""; C=($B); l="";
    for i in $I; do
        for j in $J; do
            x=${B[i]:$j:1};
            [[ "$x" != "L" && "$x" != "X" ]] && l+=$x && continue
            r=${B[i]:j+1}; r=${r//.}; R=${B[i]:0:j}; R=${R//.}
            s=${R: -1}${r:0:1}
            k=1; d=${B[i-k]:j-k:1}; while [ "$d" = '.' ]; do k=$((k+1)); d=${B[i-k]:j-k:1}; done; s+=$d
            k=1; d=${B[i-k]:j:1};   while [ "$d" = '.' ]; do k=$((k+1)); d=${B[i-k]:j:1};   done; s+=$d
            k=1; d=${B[i-k]:j+k:1}; while [ "$d" = '.' ]; do k=$((k+1)); d=${B[i-k]:j+k:1}; done; s+=$d
            k=1; d=${B[i+k]:j-k:1}; while [ "$d" = '.' ]; do k=$((k+1)); d=${B[i+k]:j-k:1}; done; s+=$d
            k=1; d=${B[i+k]:j:1};   while [ "$d" = '.' ]; do k=$((k+1)); d=${B[i+k]:j:1};   done; s+=$d
            k=1; d=${B[i+k]:j+k:1}; while [ "$d" = '.' ]; do k=$((k+1)); d=${B[i+k]:j+k:1}; done; s+=$d
            #[[ ${#s} == 8 ]] || echo "ERROR: ($s) $k = $i, $j"
            s=${s//L}
            if [[ ${#s} == 0 ]]; then l+=X; elif [[ ${#s} -ge 5 ]]; then l+=L; else l+=$x; fi
        done
        [ ${B[i]} != L${l}L ] && change+=1
        C+=(L${l}L); l=
    done
    C+=($B); B=("${C[@]}");
    [ $((++round)) = 1 ] && B=("${C[@]//X/x}")
    #[ $((round%10)) = 0 ] && echo "$round: ${#change}"
done
sum="${B[*]}"; sum=${sum//[ L.]}
echo "11B: ${#sum}"
