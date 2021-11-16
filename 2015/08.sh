#!/usr/bin/env bash
A=($(< "${1:-8.txt}"))
# shellcheck disable=SC2059
for i in "${!A[@]}"; do printf -v "B[i]" "${A[i]%\"}"; done
IFS='' total="${A[*]}" decoded="${B[*]#\"}"
printf -v encoded '"%q"' "${A[@]}"
echo "8A: $((${#total}-${#decoded}))"
echo "8B: $((${#encoded}-${#total}))"
