#!/usr/bin/env bash

INPUT_FILE="../inputs/d01.txt"

part_one() {
    local dial=50
    local sum=0

    while read -r line; do
        local dir="${line:0:1}"
        local dist="${line//[^0-9]/}"

        if [[ "$dir" == "L" ]]; then
            dial="$((dial - dist))"
        else
            dial="$((dial + dist))"
        fi

        # Keep `$dial` within 0-99; for values below 0
        while ((dial < 0)); do
            dial="$((dial + 100))"
        done

        # Keep `$dial` within 0-99; for values above 0
        while ((dial > 99)); do
            dial="$((dial - 100))"
        done

        if ((dial == 0)); then
            sum="$((sum + 1))"
        fi
    done < "$INPUT_FILE"

    echo "2025 D01 P1 = $sum"
}

main() {
    # PART ONE
    part_one
}

main
