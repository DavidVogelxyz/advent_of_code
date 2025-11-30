#!/usr/bin/env bash

INPUT_FILE="../inputs/d01.txt"

part_one() {
    local total="${#arr[@]}"

    for ((i = 0; i < ((total - 1)); i++)); do
        for ((j = i + 1; j < total; j++)); do
            if (( arr[i] + arr[j] == 2020 )); then
                l="${arr[i]}"
                r="${arr[j]}"
                break 2
            fi
        done
    done

    echo "2020 D01 P1 = $((l * r))"
}

part_two() {
    local total="${#arr[@]}"

    for ((i = 0; i < ((total - 2)); i++)); do
        for ((j = i + 1; j < ((total - 1)); j++)); do
            for ((k = i + 2; k < total; k++)); do
                if (( arr[i] + arr[j] + arr[k] == 2020 )); then
                    l="${arr[i]}"
                    m="${arr[j]}"
                    r="${arr[k]}"
                    break 3
                fi
            done
        done
    done

    echo "2020 D01 P2 = $((l * m * r))"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
