#!/usr/bin/env bash

INPUT_FILE="../inputs/d09.txt"

calculate_area() {
    coords_one="$1"
    coords_two="$2"

    read -r x_one y_one <<< "$coords_one"
    read -r x_two y_two <<< "$coords_two"

    local area="$(((x_one - x_two + 1) * (y_one - y_two + 1)))"
    area="${area#-}"

    echo "$area"
}

part_one() {
    coords=()
    local highest=0

    while IFS="," read -r x y; do
        coords+=("$x $y")
    done < "$INPUT_FILE"

    for ((i=0; i < "${#coords[@]}"; i++)); do
        for ((j=(i + 1); j < "${#coords[@]}"; j++)); do
            local a="${coords[$i]}"
            local b="${coords[$j]}"
            local area="$(calculate_area "$a" "$b")"

            if ((highest < area)); then
                highest="$area"
            fi
        done
    done

    echo "2025 D09 P1 = $highest"
}

main() {
    # PART ONE
    part_one
}

main
