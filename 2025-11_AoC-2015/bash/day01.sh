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

main() {
    # PART ONE
    part_one
}

main
