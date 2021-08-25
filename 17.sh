#! /usr/bin/env bash
A=($(< "${1:-17.txt}" ))
declare -A B CUBES
N=6
idx=({-1..18}) # 3xN
for y in "${!A[@]}"; do
    line=($(grep -o . <<< "${A[y]}"))
    for x in "${!line[@]}"; do
        [ "${line[x]}" == "#"  ] && CUBES[$((x+N)).$((y+N)).$N.$N]=1
    done
done

solve17() {
    local -A C=()
    # index fuckery. For 3D, "${IDX[@]:xyz[3]:3}" will only loop through a single $N
    local -a IDX[$N]=$N
    if [ "$1" == 4 ]; then IDX=("${idx[@]}"); fi
    for i in "${!B[@]}"; do
        xyz=(${i//./ })
        for x in "${idx[@]:xyz[0]:3}"; do
            for y in "${idx[@]:xyz[1]:3}"; do
                for z in "${idx[@]:xyz[2]:3}"; do
                    for w in "${IDX[@]:xyz[3]:3}"; do
                        C[$x.$y.$z.$w]+=1
                    done
                done
            done
        done
        C[$i]=${C[$i]/1} # don't neighbour yourself
    done
    for i in "${!C[@]}"; do
        if [[ -n "${B[$i]}" ]]; then
            [[ ${#C[$i]} == [23] ]] || unset "B[$i]"
        else
            [[ ${#C[$i]} == 3 ]] && B[$i]=1
        fi
    done
}

B=(); for i in "${!CUBES[@]}"; do B[$i]=1; done
for _ in "${idx[@]:1:N}"; do
    solve17 3
done
echo "17A: ${#B[@]}"

B=(); for i in "${!CUBES[@]}"; do B[$i]=1; done
for _ in "${idx[@]:1:N}"; do
    solve17 4
done
echo "17B: ${#B[@]}"
