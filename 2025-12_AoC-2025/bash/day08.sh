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

bubble_sort() {
    local array=("$@")
    local count="${#array[@]}"

    # default for `$operated`
    local operated=1

    for ((i = 0; i<count; i++)); do
        # set `$operated` to `0` for this loop
        operated=0

        for ((j = 0; j<(count - i - 1); j++)); do
            if ((array[j] > array[j+1])); then
                local temp="${array[$j]}"
                array[$j]="${array[$j+1]}"
                array[$j+1]="$temp"
                operated=1
            fi
        done

        if (( "$operated" == 0 )); then
            break
        fi
    done

    printf "%s\n" "${array[@]}"
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

    # Sort this list -- confirmed the shortest 10 are in agreement with prompt
    sorted=($(bubble_sort "${!dists[@]}"))

    # Print the first 10 "distances and pairs of coordinates"
    for ((i=0; i < 10; i++)); do
        local coords_one="${dists[${sorted[$i]}]%%, *}"
        local coords_two="${dists[${sorted[$i]}]##*, }"

        echo "${sorted[$i]} = dist between $coords_one and $coords_two"
    done

    # Add to arrays the pairs that connect
    # Write a way to merge two arrays when a new pair connects the two:
    #   if no connections, add both coords to new array
    #   if 1 connection, add the other coord to the same array as the conn
    #   if 2 connections, merge the two arrays into one, and unset both orig
    # Take the top 3 largest circuits (arrays)
    # Multiply the counts of those largest 3 circuits

    echo "2025 D08 P1 = $sum"
}

main() {
    # PART ONE
    part_one
}

main
