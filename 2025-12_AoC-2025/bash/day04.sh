#!/usr/bin/env bash

INPUT_FILE="../inputs/d04.txt"

part_one() {
    local rows_total="${#arr[@]}"
    local sum=0
    local num_adj_paper=0

    # Read through rows (vertically)
    for ((row=0; row < rows_total; row++)); do
        # Get the current line
        local curr=(${arr[$row]})

        # Total number of chars in row
        local cols_total="${#curr}"

        # Read through the cols (horizontally)
        for ((col=0; col < cols_total; col++)); do
            local char="${curr:$col:1}"

            # Check the rolls of paper
            if [[ "$char" == "@" ]]; then
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

                        # If `$adj_value` is a "@", increase `$num_adj_paper`
                        if [[ "$adj_value" == "@" ]]; then
                            num_adj_paper="$((num_adj_paper + 1))"
                        fi
                    done
                done

                # If `$num_adj_paper` is less than 4, increase `$sum`
                if ((num_adj_paper < 4)); then
                    sum="$((sum + 1))"
                fi

                num_adj_paper=0
            fi
        done
    done

    echo "2025 D04 P1 = $sum"
}

part_two() {
    local rows_total="${#arr[@]}"
    local sum=0
    local num_adj_paper=0
    local new_sum=-1

    while ((new_sum != sum)); do
        local new_map=()
        new_sum="$sum"

        # Read through rows (vertically)
        for ((row=0; row < rows_total; row++)); do
            local new_row=""

            # Get the current line
            local curr=(${arr[$row]})

            # Total number of chars in row
            local cols_total="${#curr}"

            # Read through the cols (horizontally)
            for ((col=0; col < cols_total; col++)); do
                local char="${curr:$col:1}"

                # Check the rolls of paper
                if [[ "$char" == "@" ]]; then
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

                            # If `$adj_value` is a "@", increase `$num_adj_paper`
                            if [[ "$adj_value" == "@" ]]; then
                                num_adj_paper="$((num_adj_paper + 1))"
                            fi
                        done
                    done

                    # If `$num_adj_paper` is less than 4
                    if ((num_adj_paper < 4)); then
                        sum="$((sum + 1))"
                        char="x"
                    fi

                    num_adj_paper=0
                fi

                # Add `$char` to the updated row
                new_row+="${char}"
            done

            # Add `$new_row` to the updated map
            new_map+=("$new_row")
        done

        # Change `$arr` to be the updated map
        arr=(${new_map[@]})
    done

    echo "2025 D04 P2 = $sum"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
