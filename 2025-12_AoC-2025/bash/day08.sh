#!/usr/bin/env bash

INPUT_FILE="../inputs/d08_test.txt"

calculate_distance() {
    local coords_one="$1"
    local coords_two="$2"

    local x_one="${coords_one%%,*}"
    local y_one="${coords_one#*,}"
    local y_one="${y_one%%,*}"
    local z_one="${coords_one##*,}"

    local x_two="${coords_two%%,*}"
    local y_two="${coords_two#*,}"
    local y_two="${y_two%%,*}"
    local z_two="${coords_two##*,}"

    local sq_x="$(((x_one - x_two) ** 2))"
    local sq_y="$(((y_one - y_two) ** 2))"
    local sq_z="$(((z_one - z_two) ** 2))"

    local sq_sum="$((sq_x + sq_y + sq_z))"

    echo "sqrt($sq_sum)" | bc
}

part_one() {
    declare -A dists
    coords=()

    while IFS="," read -r line; do
        coords+=("$line")
    done < "$INPUT_FILE"

    # Calculate distances for all pairs of coordinates
    for ((i=0; i < "${#coords[@]}"; i++)); do
        for ((j=(i + 1); j < "${#coords[@]}"; j++)); do
            local a="${coords[$i]}"
            local b="${coords[$j]}"
            local dist="$(calculate_distance "$a" "$b")"
            dists[$dist]="${a}, ${b}"
        done
    done

    # Print the distance and the pairs of coordinates
    for key in "${!dists[@]}"; do
        echo "$key = dist between ${dists[$key]}"
    done

    # Sort this list -- confirmed the shortest 10 are in agreement with prompt
    # Add to arrays the pairs that connect
    # Write a way to merge two arrays when a new pair connects the two
    # Take the top 3 largest circuits
    # Multiply the counts of those largest 3 circuits

    echo "2025 D08 P1 = $sum"
}

main() {
    # PART ONE
    part_one
}

main
