#!/usr/bin/env bash

INPUT_FILE="../inputs/d02.txt"

part_one() {
    local sum=0

    while read -r range char string; do
        # Get the lower bound
        local l="${range%%-*}"

        # Get the upper bound
        local u="${range##*-}"

        # Get the char of interest
        local c="${char%%:*}"

        # Remove all chars from string that are NOT `$c`
        local remain="${string//[^$c]/}"

        # Count the characters in `$remain`
        local count="${#remain}"

        if (( count >= l )) && (( count <= u )); then
            sum=$((sum + 1))
        fi
    done < "$INPUT_FILE"

    echo "2020 D02 P1 = $sum"
}

part_two() {
    local sum=0

    while read -r range char string; do
        # Get the lower bound
        local l="${range%%-*}"
        l=$((l - 1))

        # Get the upper bound
        local u="${range##*-}"
        u=$((u - 1))

        # Get the char of interest
        local c="${char%%:*}"

        # Skip if "low bound" and "high bound" are ever the same
        if [[ "${string:$l:1}" == "${string:$u:1}" ]]; then
            continue
        fi

        if [[ "${string:$l:1}" == "$c" ]]; then
            sum=$((sum + 1))
        elif [[ "${string:$u:1}" == "$c" ]]; then
            sum=$((sum + 1))
        fi
    done < "$INPUT_FILE"

    echo "2020 D02 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
