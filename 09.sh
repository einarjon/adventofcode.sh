#! /usr/bin/env bash
A=($(< "${1:-9.txt}"))
idx=(${!A[@]})
for i in "${idx[@]:25}"; do
    b=:
    for j in "${idx[@]:i-25:25-1}"; do
        [[ ${A[j]} -ge ${A[i]} ]] && continue
        for k in "${idx[@]:j+1:i-j-1}"; do
            ((A[j]+A[k] == A[i])) && b=break; $b
        done
        $b
    done
    [ "$b" = ":" ] && echo "9A: line $i = ${A[i]}" && break
done

k=0; j=0; sum=${A[j++]}
while [ "$sum" != "${A[i]}" ]; do
    if   [[ $sum -lt ${A[i]} ]]; then ((sum+=A[j++]))
    elif [[ $sum -gt ${A[i]} ]]; then ((sum-=A[k++]))
    fi
    [[ $j -ge $i ]] && echo NOT FOUND && break
done
B=($(printf "%s\n" "${A[*]:k:j-k+1}" | sort -n))
echo "9B: $j..$k = $((B+B[${#B[@]}-1]))"
