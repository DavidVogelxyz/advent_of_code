#!/usr/bin/env bash

INPUT_FILE="../inputs/d03.txt"

part_one() {
    local rows_total="${#arr[@]}"
    local sum=0
    local curr_num=0
    local has_adj_symbol=0

    # Read through rows (vertically)
    for ((row=0; row<rows_total; row++)); do
        # Get the current line
        local curr=(${arr[$row]})

        # Total number of chars in row
        local cols_total="${#curr}"

        # Read through the cols (horizontally)
        for ((col=0; col < cols_total; col++)); do
            local char="${curr:$col:1}"

            # Handle numbers
            if [[ "$char" == [0-9] ]]; then
                for row_offset in {-1..1}; do
                    for col_offset in {-1..1}; do
                        # Skip the "current character"
                        if ((row_offset == 0)) && ((col_offset == 0)); then
                            continue
                        fi

                        local adj_row="$((row + row_offset))"
                        local adj_col="$((col + col_offset))"

                        # Skip if `$adj_row` is off map
                        if ((adj_row < 0)) || ((adj_row >= rows_total)); then
                            continue
                        fi

                        # Skip if `$adj_col` is off map
                        if ((adj_col < 0)) || ((adj_col >= cols_total)); then
                            continue
                        fi

                        local adj_value="${arr[$adj_row]:$adj_col:1}"

                        # If `$adj_value` is a char that's not ".", flag the symbol
                        if [[ "$adj_value" != [0-9] ]] && [[ "$adj_value" != "." ]]; then
                            has_adj_symbol=1
                        fi
                    done
                done

                curr_num="$((10 * curr_num))"
                curr_num="$((curr_num + char))"

                # If the next char is off map; or, not a number; resolve
                if ((col + 1 >= cols_total)) || [[ "${curr:col+1:1}" != [0-9] ]]; then
                    if ((has_adj_symbol == 1)); then
                        sum="$((sum + curr_num))"
                    fi

                    curr_num=0
                    has_adj_symbol=0
                fi
            fi
        done
    done

    echo "2023 D03 P1 = $sum"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    part_one
}

main
