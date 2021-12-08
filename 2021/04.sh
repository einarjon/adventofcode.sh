#! /usr/bin/env bash
declare -i i
while read -r a b c d e; do
    if (( ${#NUMBERS[@]} == 0 )); then NUMBERS=(${a//,/ });
    elif [[ -n $a ]]; then
        C[i++]="-$a--$b--$c--$d--$e-" # rows
        j=$((10*(i/10))) # columns
        C[j+5]+="-$a-";C[j+6]+="-$b-";C[j+7]+="-$c-";C[j+8]+="-$d-";C[j+9]+="-$e-";
        ((i%5==0)) && i+=5
    fi
done < "${1:-4.txt}"
idx=(${!C[@]})
for k in "${!NUMBERS[@]}"; do
    n=${NUMBERS[k]}
    C=("${C[@]//-$n-}")
    B=(${C[@]}) # lazy "find empty"
    (( ${#B[@]} != ${#C[@]} )) && break
done
for i in "${idx[@]}"; do [[ -z ${C[i]} ]] && break; done
j=$((10*(i/10))) # columns
printf -v sum "%s" "${C[@]:j:5}"
sum=${sum//--/+}; sum=${sum//-}
echo "12A: $((n*(sum)))"

printf -v WON "=%d=" {0..990..10}
WON=${WON/=$j=} # only do each card once
for i in "${idx[@]:j:10}"; do C[i]=DONE; done
for k in "${!NUMBERS[@]}"; do
    n=${NUMBERS[k]}
    C=("${C[@]//-$n-}")
    B=(${C[@]})
    if (( ${#B[@]} != ${#C[@]} )); then
        for i in "${idx[@]}"; do
            if [[ -z ${C[i]} ]]; then
                j=$((10*(i/10)))
                WON=${WON/=$j=}; [[ -z $WON  ]] && break 2
                for l in "${idx[@]:j:10}"; do C[l]=DONE; done
            fi
        done
    fi
done
printf -v sum "%s" "${C[@]:j:5}"
sum=${sum//--/+}; sum=${sum//-}
echo "12B: $((n*(sum)))"
