#!/usr/bin/env bash

INPUT_FILE="../inputs/d04.txt"

part_one() {
    local sum=0

    while IFS="|" read -r card values; do
        local count=0
        local points=0

        # Get the card's number
        local num_card="${card%%:*}"
        num_card="${num_card##* }"

        # Get the card's numbers into an array
        local nums_card="${card##*: }"
        nums_card=($nums_card)

        # Get the winning numbers into an array
        local my_nums=($values)

        for ((i=0; i<"${#nums_card[@]}"; i++)); do
            for ((j=0; j<"${#my_nums[@]}"; j++)); do
                if ((nums_card[$i] == my_nums[$j])); then
                    count="$((count + 1))"
                    continue
                fi
            done
        done

        if ((count != 0)); then
            points="$((2 ** (count - 1)))"
        fi

        sum="$((sum + points))"
    done < "$INPUT_FILE"

    echo "2023 D04 P1 = $sum"
}

part_two() {
    declare -A copies
    local sum=0

    while IFS="|" read -r card values; do
        local count=0

        # Get the card's number
        local num_card="${card%%:*}"
        num_card="${num_card##* }"

        # Add the original copy
        copies[$num_card]="$((copies[$num_card] + 1))"

        # Get the card's numbers into an array
        local nums_card="${card##*: }"
        nums_card=($nums_card)

        # Get the winning numbers into an array
        local my_nums=($values)

        for ((i=0; i<"${#nums_card[@]}"; i++)); do
            for ((j=0; j<"${#my_nums[@]}"; j++)); do
                if ((nums_card[$i] == my_nums[$j])); then
                    count="$((count + 1))"
                    continue
                fi
            done
        done

        # Win copies of the next scorecards
        for ((i=1; i < count + 1; i++)); do
            copies[$((num_card + i))]="$((copies[$((num_card + i))] + copies[$num_card]))"
        done
    done < "$INPUT_FILE"

    for key in "${!copies[@]}"; do
        sum="$((sum + copies[$key]))"
    done

    echo "2023 D04 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
