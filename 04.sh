#! /usr/bin/env bash
X='epEhbiH'; x=$X; ans=0
IFS=$' \n'
A=($(sed s/^$/XXX/ "${1:-4.txt}"))
for i in "${A[@]}" XXX; do
    case $i in
        ecl:*) x=${x/e};;
        pid:*) x=${x/p};;
        eyr:*) x=${x/E};;
        hcl:*) x=${x/h};;
        byr:*) x=${x/b};;
        iyr:*) x=${x/i};;
        hgt:*) x=${x/H};;
        cid:*) : ;;
        XXX) [ -z "$x" ] && ((ans+=1)); x=$X;;
    esac
done
echo "4A: ${ans}"
x=$X; ans=0
for i in "${A[@]}" XXX; do
    k=${i/*:}
    case $i in
        ecl:amb|ecl:blu|ecl:brn|ecl:gry|ecl:grn|ecl:hzl|ecl:oth) x=${x/e};;
        pid:[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]) x=${x/p};;
        eyr:[0-9][0-9][0-9][0-9]) [[ $k -ge 2020 && $k -le 2030 ]] && x=${x/E};;
        hcl:\#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]) x=${x/h};;
        byr:[0-9][0-9][0-9][0-9]) [[ $k -ge 1920 && $k -le 2002 ]] && x=${x/b};;
        iyr:[0-9][0-9][0-9][0-9]) [[ $k -ge 2010 && $k -le 2020 ]] && x=${x/i};;
        hgt:[0-9][0-9]in) [[ ${k:0:2} -ge 59 && ${k:0:2} -le 76 ]] && x=${x/H};;
        hgt:1[0-9][0-9]cm) [[ ${k:0:3} -ge 150 && ${k:0:3} -le 193 ]] && x=${x/H};;
        cid:*) : ;;
        XXX) [ -z "$x" ] && ((ans+=1)); x=$X;;
    esac
done
echo "4B: ${ans}"
