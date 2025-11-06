#!/usr/bin/env bash

INPUT_FILE="../inputs/d03.txt"

travel() {
    local sum=0
    local x=0
    local line_len="${#arr[0]}"
    local total_lines="${#arr[@]}"

    for ((y = 0; y < total_lines; y+=d)); do
        local line="${arr[$y]}"
        local char="${line:$x:1}"

        if ! (( y == 0 )); then
            if [[ "$char" == "#" ]]; then
                sum="$(( sum + 1 ))"
            fi
        fi

        x="$(( x + r ))"

        if (( x > line_len - 1 )); then
            x="$(( x - line_len ))"
        fi
    done

    echo "$sum"
}

day_three_part_one() {
    sum="$(r=3 d=1 travel)"

    echo "$sum trees were hit while travelling."
}

day_three_part_two() {
    n1="$(r=1 d=1 travel)"
    n2="$(r=3 d=1 travel)"
    n3="$(r=5 d=1 travel)"
    n4="$(r=7 d=1 travel)"
    n5="$(r=1 d=2 travel)"

    product="$(( n1 * n2 * n3 * n4 * n5 ))"

    echo "Product of sums = $product"
}

main() {
    readarray -t arr < "$INPUT_FILE"

    # PART ONE
    #day_three_part_one

    # PART TWO
    day_three_part_two
}

main
