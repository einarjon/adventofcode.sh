#! /usr/bin/env bash
A=($(< "${1:-25.txt}"))
if [[ -n ${2:-$PUREBASH} ]]; then
    trap 'echo "Giving up after $SECONDS seconds"; exit 1' INT TERM
    echo "This could take a minute. Ctrl-C or 'kill $$' to exit"
    declare -i k=1 e=1 key1=${A[0]} key2=${A[1]}
    until ((k==key1)); do
        ((k=k*7 % 20201227, e=e*key2 % 20201227))
    done
    echo "25A: $e"
else
    echo "${A[@]}" | awk '{key1=$1; key2=$2; k=1; e=1
        while (k != key1) { k = k*7 % 20201227; e = e*key2 % 20201227 }
        print "25A(awk):", e
    }'
fi
