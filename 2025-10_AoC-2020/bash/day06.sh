#!/usr/bin/env bash

INPUT_FILE="../inputs/d06.txt"

parse_line_part_one() {
    local string="$1"
    local count="${#string}"

    for ((i=0; i < count; i++)); do
        local letter="${string:$i:1}"

        # if the `group` array does not contain the letter, add it
        if ! [[ "${group[*]}" =~ "$letter" ]]; then
            group+=("$letter")
        fi
    done
}

day_six_part_one() {
    local group=()
    local sum=0

    while read -r line; do
        if ! [[ "$line" == "" ]]; then
            parse_line_part_one "$line"
        else
            local count="${#group[@]}"
            sum="$((sum + count))"
            group=()
        fi
    done < "$INPUT_FILE"

    # Add the last group to the sum
    local count="${#group[@]}"
    sum="$((sum + count))"

    echo "The sum is ${sum}."
}

main() {
    # PART ONE
    day_six_part_one
}

main
