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

part_one() {
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

    echo "2020 D06 P1 = $sum"
}

parse_line_part_two() {
    local string="$1"
    local count="${#string}"
    person="$((person + 1))"

    if ((person == 1)); then
        for ((i=0; i < count; i++)); do
            local letter="${string:$i:1}"

            # if the `group` array does not contain the letter, add it
            if ! [[ "${group[*]}" =~ "$letter" ]]; then
                group+=("$letter")
            fi
        done
    else
        local count_group="${#group[@]}"

        for ((i=0; i < count_group; i++)); do
            local letter="${group[$i]}"

            # if `$string` does not contain the letter, remove it
            if ! [[ "${string[*]}" =~ "$letter" ]]; then
                unset group[$i]
            fi
        done

        # Re-index `group` array
        group=("${group[@]}")
    fi
}

part_two() {
    local group=()
    local person=0
    local sum=0

    while read -r line; do
        if ! [[ "$line" == "" ]]; then
            parse_line_part_two "$line"
        else
            local count="${#group[@]}"
            sum="$((sum + count))"
            group=()
            person=0
        fi
    done < "$INPUT_FILE"

    # Add the last group to the sum
    local count="${#group[@]}"
    sum="$((sum + count))"

    echo "2020 D06 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
