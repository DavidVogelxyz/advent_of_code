#!/usr/bin/env bash

INPUT_FILE="../inputs/d07.txt"

part_one() {
    declare -A tachyon
    local rows_total="${#arr[@]}"
    local sum=0

    # Read through rows (vertically)
    for ((row=0; row < rows_total; row++)); do
        # Get the current line
        local curr=(${arr[$row]})

        # Total number of chars in row
        local cols_total="${#curr}"

        # Read through the cols (horizontally)
        for ((col=0; col < cols_total; col++)); do
            local char="${curr:$col:1}"

            # Check the characters
            if [[ "$char" == "S" ]]; then
                tachyon[$col]=1
            elif [[ "$char" == "^" ]]; then
                if ((tachyon[$col] == 1 )); then
                    unset tachyon[$col]

                    tachyon[$((col - 1))]=1
                    tachyon[$((col + 1))]=1

                    sum="$((sum + 1))"
                fi
            fi
        done
    done

    echo "2025 D07 P1 = $sum"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    part_one
}

main
