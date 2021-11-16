#!/usr/bin/env bash
A=($(tr -cd "0-9 " < "${1:-22.txt}"))
HP2=${A[0]}
DAMAGE=${A[1]}
HP1=50
MANA=500
#Magic Missile costs 53 mana. It instantly does 4 damage.
#Drain costs 73 mana. It instantly does 2 damage and heals you for 2 hit points.
#Shield costs 113 mana. lasts for 6 turns. While it is active, your armor is increased by 7.
#Poison costs 173 mana. lasts for 6 turns. while it is active, it deals the boss 3 damage.
#Recharge costs 229 mana. lasts for 5 turns. while it is active, it gives you 101 new mana.
COST=(53 73 113 173 229 0)
IDX=({4..0})
r() {
    local spent=$1 mana=$2 shield=$3 poison=$4 recharge=$5 hp1=$6 hp2=$7 choice=$8 penalty=$9
        ((spent >= MIN && ++giveup)) && return # too much mana spent
    case $choice in
         0) ((hp2-=4));;
         1) ((hp1+=2,hp2-=2));;
         2) shield=6;;
         3) poison=6;;
         4) recharge=5;;
         5) :;;
    esac

    # enemy turn
    ((shield-- > 0))&& ((hp1+=7))
    ((poison-- > 0)) && ((hp2-=3))
    ((recharge-- > 0)) && ((mana+=101))
    if ((hp2 <= 0 && ++win)); then
        #echo WON: $spent/$MIN : $hp1 left : ${10}
        MIN=($spent ${10} enemy_turn $hp1)
        return
    fi
    ((hp1-=DAMAGE+penalty))
    ((hp1 <= 0 && ++fail)) && return # you die
    # my turn
    ((shield--))
    ((poison-- > 0)) && ((hp2-=3))
    ((recharge-- > 0)) && ((mana+=101))
    if ((hp2 <= 0 && ++win)); then
        #echo WON: $spent/$MIN : $hp1 left : ${10}
        MIN=($spent ${10} my_turn $hp1)
        return
    fi
    for k in "${IDX[@]}"; do
        ((mana < COST[k])) && continue # can't afford
        ((shield   > 0 && k == 2 )) && continue
        ((poison   > 0 && k == 3 )) && continue
        ((recharge > 0 && k == 4 )) && continue
        r "$((spent+COST[k]))" "$((mana-COST[k]))" "$shield" "$poison" "$recharge" "$hp1" "$hp2" "$k" "$penalty" "${10}-$k"
    done
}

FIRST=(${IDX[@]}) # very slow
FIRST=(3)         # faster
MIN=(10000) win=0 fail=0 giveup=0 penalty=0
for i in "${FIRST[@]}"; do
    r "${COST[i]}" $((MANA-COST[i])) 0 0 0 "$((HP1-penalty))" "$HP2" "$i" "$penalty" "$i"
done
echo "22A: ${MIN[0]}"  #": ${MIN[*]} - $win/$fail/$giveup - $SECONDS"
MIN=(10000) win=0 fail=0 giveup=0 penalty=1
FIRST=(2)       # faster
for i in "${FIRST[@]}"; do
    r "${COST[i]}" $((MANA-COST[i])) 0 0 0 "$((HP1-penalty))" "$HP2" "$i" "$penalty" "$i"
done
echo "22B: ${MIN[0]}"  #": ${MIN[*]} - $win/$fail/$giveup - $SECONDS"
