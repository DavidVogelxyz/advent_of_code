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
                if ((tachyon[$col] > 0 )); then
                    for offset in {-1,1}; do
                        index="$((col + offset))"
                        tachyon[$index]="$((tachyon[$index] + tachyon[$col]))"
                    done

                    unset tachyon[$col]
                    sum="$((sum + 1))"
                fi
            fi
        done
    done

    echo "2025 D07 P1 = $sum"
}

part_two() {
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
                if ((tachyon[$col] > 0 )); then
                    for offset in {-1,1}; do
                        index="$((col + offset))"
                        tachyon[$index]="$((tachyon[$index] + tachyon[$col]))"
                    done

                    unset tachyon[$col]
                fi
            fi
        done
    done

    for key in "${!tachyon[@]}"; do
        sum="$((sum + tachyon[$key]))"
    done

    echo "2025 D07 P2 = $sum"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
