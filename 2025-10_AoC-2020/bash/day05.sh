#!/usr/bin/env bash

INPUT_FILE="../inputs/d05.txt"

# takes a string of either "F & B", or "L & R" as input
# returns an integer as output
binary_search() {
    local INPUT="$1"
    local count="${#INPUT}"
    local l=0
    local h="$((2 ** count - 1))"
    local last_char="$((count - 1))"

    for ((i=0; i < last_char; i++)); do
        # Get the character at the index
        local c="${INPUT:$i:1}"

        # Get the size of a half
        local half="$(((h - l + 1) / 2))"

        if [[ "$c" == "F" ]] || [[ "$c" == "L" ]]; then
            h="$((h - half))"
        elif [[ "$c" == "B" ]] || [[ "$c" == "R" ]]; then
            l="$((l + half))"
        fi
    done

    # Get the last character
    local c="${INPUT:$last_char:1}"

    if [[ "$c" == "F" ]] || [[ "$c" == "L" ]]; then
        result="$l"
    elif [[ "$c" == "B" ]] || [[ "$c" == "R" ]]; then
        result="$h"
    fi

    echo "$result"
}

day_five_part_one() {
    local highest=0

    while read -r bsp; do
        local row="${bsp:0:7}"
        local col="${bsp:7:3}"

        row="$(binary_search "$row")"
        col="$(binary_search "$col")"

        local seat_ID="$((8 * row + col))"

        if ((highest < seat_ID)); then
            highest="$seat_ID"
        fi
    done < "$INPUT_FILE"

    echo "The highest seat ID is ${highest}."
}

main() {
    # PART ONE
    day_five_part_one
}

main
