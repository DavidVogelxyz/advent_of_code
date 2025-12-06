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

part_two() {
    declare -A col_sym
    local columns=()
    local row_total="${#arr[@]}"
    local last_row="$((row_total - 1))"
    local sum=0
    local total_chars_in_line=0

    # Read the last line
    IFS=" " read -r -a symbols <<< "${arr[$last_row]}"
    local count="${#symbols[@]}"
    local op_count="$((count - 1))"

    # For symbols in last line, add symbol to associative array `col_sym`
    for ((i=0; i < count; i++)); do
        col_sym[$i]="${symbols[$i]}"
    done

    # Read every line except the last to get `total_chars_in_line`
    for ((row=0; row < row_total - 1; row++)); do
        local chars_in_line="${#arr[$row]}"

        if ((total_chars_in_line < chars_in_line)); then
            total_chars_in_line="$chars_in_line"
        fi
    done

    local col_max="$((total_chars_in_line - 1))"

    # Read by columns
    for ((col="$col_max"; col >= 0; col--)); do
        local new_num=""

        # For each column, read each row (except the last)
        for ((row=0; row < row_total - 1; row++)); do
            local line="${arr[$row]}"
            local chars_in_line=${#line}
            local line_col_max="$((chars_in_line - 1))"

            # If "out of bounds", continue
            if ((line_col_max < col)); then
                continue
            fi

            # Grab the character from this column, for this row
            local value="${arr[$row]:$col:1}"

            # If `value` is empty, continue
            if [[ "$value" == " " ]]; then
                continue
            fi

            # Add `value` to `new_num`
            new_num+="$value"
        done

        # If `new_num` is completely empty, blank column; so, go to next symbol
        if [[ "$new_num" == "" ]]; then
            op_count="$((op_count - 1))"
            continue
        fi

        # If symbol is `+`, add numbers together
        if [[ "${col_sym[$op_count]}" == "+" ]]; then
            columns[$op_count]="$((columns[$op_count] + new_num))"
        # If symbol is `*`, multiply numbers; except, when first number, add
        elif [[ "${col_sym[$op_count]}" == "*" ]]; then
            if [[ "${columns[$op_count]}" == "" ]]; then
                columns[$op_count]="$((columns[$op_count] + new_num))"
            else
                columns[$op_count]="$((columns[$op_count] * new_num))"
            fi
        fi
    done

    # Get the grand total
    for key in "${!columns[@]}"; do
        sum="$((sum + columns[$key]))"
    done

    echo "2025 D06 P2 = $sum"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
