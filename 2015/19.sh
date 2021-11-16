#!/usr/bin/env bash
declare -A A=() B=()
while read -r a b c; do
    case $b in
        "=>") A[$a]+=" $c";;
        "") MOL=$a;;
    esac
done < "${1:-19.txt}"

for i in ${!A[*]}; do
    X=(${MOL//$i/_ _}); idx=(${!X[@]})
    for j in ${A[$i]}; do
        for k in ${idx[*]:1}; do
            y=${X[*]:0:k}$j${X[*]:$k}
            y=${y// /$i}
            ((++B[${y//_}]))
        done
    done
done
echo "19A: ${#B[@]}"

declare -i n=0
until [[ ${MOL} == 'e' ]]; do
    for i in ${!A[*]}; do
        (( ${#MOL} > 3 )) && [[ $i == 'e' ]] && continue
        for j in ${A[$i]}; do
            new=${MOL/$j/$i}
            if [[ "$MOL" != "$new" ]]; then MOL=$new; n+=1; fi
        done
    done
#    echo $n: ${#MOL}
done
echo "19B: $n"
