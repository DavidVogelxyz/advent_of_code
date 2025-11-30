#!/usr/bin/env bash

INPUT_FILE="../inputs/d01.txt"

part_one() {
    local sum=0

    while read -r line; do
        # Keep only nums from `$line`
        local num="${line//[^0-9]/}"

        # From `$num`, take first and last num and create new num
        num="${num:0:1}${num: -1:1}"

        sum="$((sum + num))"
    done < "$INPUT_FILE"

    echo "2023 D01 P1 = $sum"
}

main() {
    # PART ONE
    part_one
}

main
