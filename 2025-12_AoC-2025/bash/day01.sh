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

part_two() {
    local dial=50
    local sum=0

    while read -r line; do
        local dir="${line:0:1}"
        local dist="${line//[^0-9]/}"

        # Remove "double count" when starting at 0 and going left
        if ((dial == 0)) && [[ "$dir" == "L" ]]; then
            sum="$((sum - 1))"
        fi

        if [[ "$dir" == "L" ]]; then
            dial="$((dial - dist))"
        else
            dial="$((dial + dist))"
        fi

        # Keep `$dial` within 0-99; for values below 0
        while ((dial < 0)); do
            dial="$((dial + 100))"
            sum="$((sum + 1))"
        done

        # Keep `$dial` within 0-99; for values above 0
        while ((dial > 99)); do
            # Remove "double count" when going from 100 to 0
            if ((dial == 100)); then
                sum="$((sum - 1))"
            fi

            dial="$((dial - 100))"
            sum="$((sum + 1))"
        done

        if ((dial == 0)); then
            sum="$((sum + 1))"
        fi
    done < "$INPUT_FILE"

    echo "2025 D01 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
