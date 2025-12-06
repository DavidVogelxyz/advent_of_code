#!/usr/bin/env bash

INPUT_FILE="../inputs/d06.txt"

part_one() {
    declare -A col_sym
    local columns=()
    local row_total="${#arr[@]}"
    local last_row="$((row_total - 1))"
    local sum=0

    # Read the last line
    IFS=" " read -r -a symbols <<< "${arr[$last_row]}"
    local count="${#symbols[@]}"

    # For symbols in last line, add symbol to associative array `col_sym`
    for ((i=0; i < count; i++)); do
        col_sym[$i]="${symbols[$i]}"
    done

    # Read every line except the last
    for ((row=0; row < row_total - 1; row++)); do
        local line=(${arr[$row]})
        local col=0

        for num in "${line[@]}"; do
            # If symbol is `+`, add numbers together
            if [[ "${col_sym[$col]}" == "+" ]]; then
                columns[$col]="$((columns[$col] + num))"
            # If symbol is `*`, multiply numbers; except, when first number, add
            elif [[ "${col_sym[$col]}" == "*" ]]; then
                if [[ "${columns[$col]}" == "" ]]; then
                    columns[$col]="$((columns[$col] + num))"
                else
                    columns[$col]="$((columns[$col] * num))"
                fi
            fi

            col="$((col + 1))"
        done
    done

    # Get the grand total
    for key in "${!columns[@]}"; do
        sum="$((sum + columns[$key]))"
    done

    echo "2025 D06 P1 = $sum"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    part_one
}

main
