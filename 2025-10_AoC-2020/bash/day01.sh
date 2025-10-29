#!/usr/bin/env bash

INPUT_FILE="../inputs/d01.txt"

add_array() {
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

    if ! [[ "$l" ]]; then
        echo "Something went wrong... 😭😭😭" && exit 1
    else
        echo "The product of $l and $r = $((l * r))"
    fi
}

main() {
    local arr=($(<"${INPUT_FILE}"))

    add_array
}

main
