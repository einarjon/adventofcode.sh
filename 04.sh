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
    case $i in
        ecl:amb|ecl:blu|ecl:brn|ecl:gry|ecl:grn|ecl:hzl|ecl:oth) x=${x/e};;
        pid:[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]) x=${x/p};;
        eyr:202[0-9]|eyr:2030)              x=${x/E};;   # 2020-2030
        hcl:\#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]) x=${x/h};;
        byr:19[2-9][0-9]|byr:200[0-2])      x=${x/b};;   # 1920-2002
        iyr:201[0-9]|iyr:2020)              x=${x/i};;   # 2010-2020
        hgt:59in|hgt:6[0-9]in|hgt:7[0-6]in) x=${x/H};;   # 59-76 in
        hgt:1[5-8][0-9]cm|hgt:19[0-3]cm)    x=${x/H};;   # 150-193 cm
        cid:*) : ;;
        XXX) [ -z "$x" ] && ((ans+=1)); x=$X;;
    esac
done
echo "4B: ${ans}"
