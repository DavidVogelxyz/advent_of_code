#!/usr/bin/env bash

INPUT_FILE="../inputs/d08.txt"

calculate_distance() {
    local coords_one="$1"
    local coords_two="$2"

    local x_one y_one z_one
    local x_two y_two z_two

    IFS="," read -r x_one y_one z_one <<< "$coords_one"
    IFS="," read -r x_two y_two z_two <<< "$coords_two"

    local sq_sum="$(((x_one - x_two) ** 2 + (y_one - y_two) ** 2 + (z_one - z_two) ** 2))"

    echo "$sq_sum"
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
    connections=()

    while IFS="," read -r line; do
        coords+=("$line")
    done < "$INPUT_FILE"

    # Calculate distances for all pairs of coordinates
    for ((i=0; i < "${#coords[@]}"; i++)); do
        for ((j=(i + 1); j < "${#coords[@]}"; j++)); do
            local a="${coords[$i]}"
            local b="${coords[$j]}"
            local dist="$(calculate_distance "$a" "$b")"
            dists[$dist]="${a} ${b}"
        done

        if ((i != 0)) && ((i % 20 == 0)); then
            echo "completed 20 distances, at $i"
        fi
    done

    echo "got all distances for coords"
    echo "now, sorting the dists"

    # Sort the distances
    sorted_dists=($(bubble_sort "${!dists[@]}"))

    echo "sorted the dists"
    #echo "doing 10 connections"
    echo "doing 1,000 connections"

    # Add to arrays the pairs that connect
    # Only do the first 10 "distances and pairs of coordinates"
    for ((i=0; i < 1000; i++)); do
        local coords_one="${dists[${sorted_dists[$i]}]%% *}"
        local coords_two="${dists[${sorted_dists[$i]}]##* }"
        local add_one_to=""
        local add_two_to=""

        # Check if `$coords_one` exists as a previous connection
        for ((j=0; j < ${#connections[@]}; j++)); do
            if [[ "${connections[$j]}" =~ "$coords_one" ]]; then
                add_two_to="$j"
            fi
        done

        # Check if `$coords_two` exists as a previous connection
        for ((j=0; j < ${#connections[@]}; j++)); do
            if [[ "${connections[$j]}" =~ "$coords_two" ]]; then
                add_one_to="$j"
            fi
        done

        # if 0 connections, add both coords to new array
        if ! [[ "$add_one_to" ]] && ! [[ "$add_two_to" ]]; then
            local index="${#connections[@]}"

            connections[$index]+=" $coords_one"
            connections[$index]+=" $coords_two"
        fi

        # if 1 connection, add the other coord to the same array as the conn
        if [[ "$add_one_to" ]] && ! [[ "$add_two_to" ]]; then
            connections[$add_one_to]+=" $coords_one"
        fi

        # if 1 connection, add the other coord to the same array as the conn
        if ! [[ "$add_one_to" ]] && [[ "$add_two_to" ]]; then
            connections[$add_two_to]+=" $coords_two"
        fi

        # if 2 connections, and both aren't part of the same network
        if [[ "$add_one_to" ]] && [[ "$add_two_to" ]] && ((add_one_to != add_two_to)); then
            local index="${#connections[@]}"

            # Merge the two connections into one new connection
            connections[$index]="${connections[$add_one_to]}${connections[$add_two_to]}"

            # Unset the original entries for those connections
            unset connections[$add_one_to]
            unset connections[$add_two_to]

            # Reorder the array
            connections=("${connections[@]}")
        fi

        if ((i != 0)) && ((i % 20 == 0)); then
            echo "completed 20 connections, at $i"
        fi
    done

    #echo "done with 10 connections"
    echo "done with 1,000 connections"

    local network_sizes=()

    echo "adding net sizes to array"

    # Add the network sizes to the `network_sizes` array
    for ((i=0; i<"${#connections[@]}"; i++)); do
        local network=(${connections[$i]})
        local net_size="${#network[@]}"
        network_sizes+=("$net_size")
    done

    echo "sorting net sizes array"

    # Sort the network sizes
    sorted_net_sizes=($(bubble_sort "${network_sizes[@]}"))

    echo "sorted the net sizes array"

    # Multiply the counts of the largest 3 circuits
    sum="$((sorted_net_sizes[-1] * sorted_net_sizes[-2] * sorted_net_sizes[-3]))"

    echo "2025 D08 P1 = $sum"
}

part_two() {
    declare -A dists
    sorted_dists=()
    connections=()
    local sum=0

    while read -r dist coords_one coords_two; do
        dists[$dist]="$coords_one $coords_two"
        sorted_dists+=("$dist")
    done < "day08_sorted-dists.txt"

    # Add to arrays the pairs that connect
    for ((i=0; i < 500000; i++)); do
        local coords_one="${dists[${sorted_dists[$i]}]%% *}"
        local coords_two="${dists[${sorted_dists[$i]}]##* }"
        local add_one_to=""
        local add_two_to=""

        # Check if `$coords_one` exists as a previous connection
        for ((j=0; j < ${#connections[@]}; j++)); do
            if [[ "${connections[$j]}" =~ "$coords_one" ]]; then
                add_two_to="$j"
            fi
        done

        # Check if `$coords_two` exists as a previous connection
        for ((j=0; j < ${#connections[@]}; j++)); do
            if [[ "${connections[$j]}" =~ "$coords_two" ]]; then
                add_one_to="$j"
            fi
        done

        # if 0 connections, add both coords to new array
        if ! [[ "$add_one_to" ]] && ! [[ "$add_two_to" ]]; then
            local index="${#connections[@]}"

            connections[$index]+=" $coords_one"
            connections[$index]+=" $coords_two"
        fi

        # if 1 connection, add the other coord to the same array as the conn
        if [[ "$add_one_to" ]] && ! [[ "$add_two_to" ]]; then
            connections[$add_one_to]+=" $coords_one"
        fi

        # if 1 connection, add the other coord to the same array as the conn
        if ! [[ "$add_one_to" ]] && [[ "$add_two_to" ]]; then
            connections[$add_two_to]+=" $coords_two"
        fi

        # if 2 connections, and both aren't part of the same network
        if [[ "$add_one_to" ]] && [[ "$add_two_to" ]] && ((add_one_to != add_two_to)); then
            local index="${#connections[@]}"

            # Merge the two connections into one new connection
            connections[$index]="${connections[$add_one_to]}${connections[$add_two_to]}"

            # Unset the original entries for those connections
            unset connections[$add_one_to]
            unset connections[$add_two_to]

            # Reorder the array
            connections=("${connections[@]}")
        fi

        local network=(${connections[0]})
        local net_size="${#network[@]}"

        if (( ${#connections[@]} == 1 )) && (( net_size > 999 )); then
            IFS="," read -r x_one y_one z_one <<< "$coords_one"
            IFS="," read -r x_two y_two z_two <<< "$coords_two"

            sum="$((x_one * x_two))"
            break
        fi
    done

    echo "2025 D08 P2 = $sum"
}

main() {
    # PART ONE
    #part_one

    # PART TWO
    part_two
}

main
