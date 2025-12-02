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

part_two() {
    local sum=0

    while read -r line; do
        # Swap words for numbers, but keep bordering letters in case of overlap
        line="${line//one/o1e}"
        line="${line//two/t2e}"
        line="${line//three/t3e}"
        line="${line//four/f4r}"
        line="${line//five/f5e}"
        line="${line//six/s6x}"
        line="${line//seven/s7n}"
        line="${line//eight/e8t}"
        line="${line//nine/n9e}"

        # Keep only nums from `$line`
        local num="${line//[^0-9]/}"

        # From `$num`, take first and last num and create new num
        num="${num:0:1}${num: -1:1}"

        sum="$((sum + num))"
    done < "$INPUT_FILE"

    echo "2023 D01 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
