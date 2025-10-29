#!/usr/bin/env bash

INPUT_FILE="../inputs/d02.txt"

valid_part_one() {
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

    echo "The # of valid passwords = $sum"
}

valid_part_two() {
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

        if [[ "${string:$l:1}" == "$c" ]]; then
            if ! [[ "${string:$u:1}" == "$c" ]]; then
                sum=$((sum + 1))
            fi
        elif [[ "${string:$u:1}" == "$c" ]]; then
            sum=$((sum + 1))
        fi
    done < "$INPUT_FILE"

    echo "The # of valid passwords = $sum"
}

main() {
    valid_part_two
}

main
