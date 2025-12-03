#!/usr/bin/env bash

INPUT_FILE="../inputs/d03.txt"

part_one() {
    local sum=0

    while read -r line; do
        local count="${#line}"
        local num_largest=0
        local num_second=0
        local pos_largest=0
        local curr_num=0

        # Get the largest number that's not the last number
        for ((i=0; i < count - 1; i++)); do
            curr_num="${line:$i:1}"

            if ((num_largest < curr_num)); then
                num_largest="$curr_num"
                pos_largest="$i"
            fi
        done

        local next_pos="$((pos_largest + 1))"

        # Get the second largest number to the right of `$num_largest`
        for ((i="$next_pos"; i < count; i++)); do
            curr_num="${line:$i:1}"

            if ((num_second < curr_num)); then
                num_second="$curr_num"
            fi
        done

        local jolt="${num_largest}${num_second}"
        sum="$((sum + jolt))"
    done < "$INPUT_FILE"

    echo "2025 D03 P1 = $sum"
}

part_two() {
    local sum=0

    while read -r line; do
        local nums=()
        local count="${#line}"
        local num_largest=0
        local pos_largest=0
        local curr_num=0
        local next_pos=0

        for ((i=11; i >= 0; i--)); do
            for ((j=$next_pos; j < count - i; j++)); do
                curr_num="${line:$j:1}"

                if ((num_largest < curr_num)); then
                    num_largest="$curr_num"
                    pos_largest="$j"
                fi
            done

            nums+=("$num_largest")
            num_largest=0
            next_pos="$((pos_largest + 1))"
        done

        local jolt=""

        for num in "${nums[@]}"; do
            jolt+="$num"
        done

        sum="$((sum + jolt))"
    done < "$INPUT_FILE"

    echo "2025 D03 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
