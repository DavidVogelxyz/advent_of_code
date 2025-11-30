#!/usr/bin/env bash

INPUT_FILE="../inputs/d01.txt"

bubble_sort() {
    local array=("$@")
    local count="${#array[@]}"

    # default for `$operated`
    local operated=1

    for ((i = 0; i<count; i++)); do
        # set `$operated` to `0` for this loop
        operated=0

        for ((j = 0; j<(count - i - 1); j++)); do
            if ((array[j] > array[j+1])); then
                local temp="${array[$j]}"
                array[$j]="${array[$j+1]}"
                array[$j+1]="$temp"
                operated=1
            fi
        done

        if (( "$operated" == 0 )); then
            break
        fi
    done

    printf "%s\n" "${array[@]}"
}

part_one() {
    local l_col=()
    local r_col=()
    local diff=0

    while read -r line; do
        local l="${line%% *}"
        local r="${line##* }"

        l_col+=("$l")
        r_col+=("$r")
    done < "$INPUT_FILE"

    local l_sorted=($(bubble_sort "${l_col[@]}"))
    local r_sorted=($(bubble_sort "${r_col[@]}"))

    local total="${#l_sorted[@]}"

    for ((i=0; i<total; i++)); do
        # Get the diff
        d="$((l_sorted[$i] - r_sorted[$i]))"

        # Get the absolute value of the diff
        d="${d#-}"

        diff="$((diff + d))"
    done

    echo "2024 D01 P1 = $diff"
}

main() {
    # PART ONE
    part_one
}

main
