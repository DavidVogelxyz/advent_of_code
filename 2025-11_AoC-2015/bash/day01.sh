#!/usr/bin/env bash

INPUT_FILE="../inputs/d01.txt"

part_one() {
    local sum=0

    while read -r line; do
        local count="${#line}"

        for ((i=0; i < count; i++)); do
            local c="${line:i:1}"

            if [[ "$c" == "(" ]]; then
                sum="$((sum + 1))"
            elif [[ "$c" == ")" ]]; then
                sum="$((sum - 1))"
            fi
        done
    done < "$INPUT_FILE"

    echo "Santa will arrive on floor #${sum}."
}

part_two() {
    local sum=0

    while read -r line; do
        local count="${#line}"

        for ((i=0; i < count; i++)); do
            local c="${line:i:1}"

            if [[ "$c" == "(" ]]; then
                sum="$((sum + 1))"
            elif [[ "$c" == ")" ]]; then
                sum="$((sum - 1))"
            fi

            if ((sum == -1)); then
                # According to AoC, if the first character was a `)`, that would be position `1`, not `0`.
                echo "The position of the first character that causes Santa to arrive at floor \`-1\` is position $((i + 1))."
                break
            fi
        done
    done < "$INPUT_FILE"
}

main() {
    # PART ONE
    #part_one

    # PART TWO
    part_two
}

main
