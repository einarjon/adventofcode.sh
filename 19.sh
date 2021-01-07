#! /usr/bin/env bash
IFS=$'\n'
input=${1:-19.txt}
A=($(grep : $input))
for i in "${A[@]}"; do
    n=${i/:*}
    RULE[n]="${i/*: }"
    RULE[n]="${RULE[n]//\"}"
done

IFS=$' \n'
REGEX=()
r(){
    local x=""
    for i; do
      if [ -z "${i/[ab|]}" ]; then
          x+=$i
      else
          [[ "${REGEX[$i]}" == "" ]] && REGEX[$i]="($(r ${RULE[$i]}))"
          x+="${REGEX[$i]}"
#           x+="($(r ${RULE[$i]}))"
     fi
    done
    echo "$x"
}
regex=$(r ${RULE[0]})
echo "19A: $(grep -E -c "^${regex}$" $input)"

#RULE[8]="42 8"
#RULE[11]="42 31 | 42 11 31"
r42="($(r ${RULE[42]}))"
r31="($(r ${RULE[31]}))"
r8="${r42}{1,5}"
r11="${r42}${r31}"
for n in {2..5}; do r11+="|${r42}{$n}${r31}{$n}"; done
echo "19B: $(grep -E -c "^($r8)($r11)$" $input)"
