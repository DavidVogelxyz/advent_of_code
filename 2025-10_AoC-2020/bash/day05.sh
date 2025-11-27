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

bubble_sort() {
    local array=("$@")
    local count="${#array[@]}"

    # default for `$operated`
    local operated=1

    for ((i = 0; i < count; i++)); do
        # set `$operated` to `0` for this loop
        operated=0

        for ((j = 0; j < (count - i - 1); j++)); do
            if (( ${array[j]} > ${array[$((j+1))]} )); then
                local temp="${array[j]}"
                array[$j]="${array[$((j+1))]}"
                array[$((j+1))]="$temp"
                operated=1
            fi
        done

        if (( "$operated" == 0 )); then
            break
        fi
    done

    printf "%s\n" "${array[@]}"
}

find_missing() {
    local last=0

    for num in "${@}"; do
        if ((last == 0)) || (( (last + 1) == num )) ; then
            last="$num"
        else
            local result="$((last + 1))"
            echo "$result"
            return
        fi
    done
}

day_five_part_two() {
    local seats=()

    while read -r bsp; do
        local row="${bsp:0:7}"
        local col="${bsp:7:3}"

        row="$(binary_search "$row")"
        col="$(binary_search "$col")"

        local seat_ID="$((8 * row + col))"

        seats+=($seat_ID)
    done < "$INPUT_FILE"

    sorted=($(bubble_sort "${seats[@]}"))
    result=$(find_missing "${sorted[@]}")

    echo "The seat ID is ${result}."
}

main() {
    # PART ONE
    #day_five_part_one

    # PART TWO
    day_five_part_two
}

main
