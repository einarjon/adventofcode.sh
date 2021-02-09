#! /usr/bin/env bash
A=($(< "${1:-17.txt}" ))
declare -A B B2
N=6
idx=({-1..18}) # 3xN
for y in "${!A[@]}"; do
    line=($(grep -o . <<< ${A[y]}))
    for x in "${!line[@]}"; do
        [ "${line[x]}" == "#"  ] && B[$((x+N)).$((y+N)).$N]=1
    done
done
for i in "${!B[@]}"; do B2[$i]=1; done

solve17() {
    local -A C=()
    for i in "${!B[@]}"; do
        xyz=(${i//./ })
        for x in "${idx[@]:xyz[0]:3}"; do
            for y in "${idx[@]:xyz[1]:3}"; do
                for z in "${idx[@]:xyz[2]:3}"; do
                    C[$x.$y.$z]+=1
                done
            done
        done
        C[$i]=${C[$i]/1} # don't neighbour yourself
    done
    for i in "${!C[@]}"; do
        if [[ -n "${B[$i]}" ]]; then
            [[ ${#C[$i]} == 2 || ${#C[$i]} == 3 ]] || unset "B[$i]"
        else
            [[ ${#C[$i]} == 3 ]] && B[$i]=1
        fi
    done
}
for _ in "${idx[@]:1:N}"; do
    solve17
done
echo "17A: ${#B[@]}"

solve17B() {
    local -A C=()
    for i in "${!B[@]}"; do
        xyz=(${i//./ })
        for x in "${idx[@]:xyz[0]:3}"; do
            for y in "${idx[@]:xyz[1]:3}"; do
                for z in "${idx[@]:xyz[2]:3}"; do
                    for w in "${idx[@]:xyz[3]:3}"; do
                        C[$x.$y.$z.$w]+=1
                    done
                done
            done
        done
        C[$i]=${C[$i]/1} # don't neighbour yourself
    done
    for i in "${!C[@]}"; do
        if [[ -n "${B[$i]}" ]]; then
            [[ ${#C[$i]} == 2 || ${#C[$i]} == 3 ]] || unset "B[$i]"
        else
            [[ ${#C[$i]} == 3 ]] && B[$i]=1
        fi
    done
}
B=() # Clear and set to x.y.z.w
for i in "${!B2[@]}"; do B[$i.$N]=1; done
for _ in "${idx[@]:1:N}"; do
    solve17B
done
echo "17B: ${#B[@]}"
