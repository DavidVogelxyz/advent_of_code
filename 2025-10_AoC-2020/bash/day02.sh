#!/usr/bin/env bash

INPUT_FILE="../inputs/d02.txt"

main() {
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

main
