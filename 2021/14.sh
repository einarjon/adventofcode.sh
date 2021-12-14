#!/usr/bin/env bash
input=${1:-14.txt}
declare -A SET=()
declare -iA COUNT=()
POL=$(head -1 "${input}")
while read -r a _ b;do
    SET[$a]="${a:0:1}$b $b${a:1}";
done < <( grep ' -> ' "${input}")
for ((i=0; i<${#POL}-1;i++)); do
    j=${POL:i:2}
    COUNT[$j]+=1;
done

solve() {
    for ((; round < $1; round++)); do
        local -iA NEW_COUNT=()
        for j in "${!COUNT[@]}"; do
            for k in ${SET[$j]}; do
                NEW_COUNT[$k]+=${COUNT[$j]}
            done
        done
        COUNT=()
        for j in "${!NEW_COUNT[@]}"; do COUNT[$j]=${NEW_COUNT[$j]}; done
    done
}
diff() {
    local -n ans=$1
    local -Ai ALPHA=([${POL:0:1}]=1 [${POL: -1}]=1) # ends are only counted once
    for k in "${!COUNT[@]}"; do
        ALPHA[${k:0:1}]+=$((COUNT["$k"]))
        ALPHA[${k:1}]+=$((COUNT["$k"]))
    done
    FREQ=($(printf "%s\n" "${ALPHA[@]}" | sort -n))
    #shellcheck disable=SC2034
    ans=$((FREQ[-1]/2-FREQ[0]/2))
}

round=0
for i in 10 40;do
    solve $i
    diff "ANS[n++]"
done
echo "14A: ${ANS[0]}"
echo "14B: ${ANS[1]}"
