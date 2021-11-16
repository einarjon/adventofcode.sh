#!/usr/bin/env bash
input=${1:-5.txt}
printf "5A: "; grep -E "(.)\1" "$input"| grep -E "[aeiou].*[aeiou].*[aeiou]" | grep -E -v -c "(ab|cd|pq|xy)"
printf "5B: "; grep -E "(..).*\1" "$input" | grep -E "(.).\1" -c
