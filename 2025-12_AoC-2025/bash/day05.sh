#!/usr/bin/env bash

INPUT_FILE="../inputs/d05.txt"

part_one() {
    local valids=()
    local sum=0

    while read -r line; do
        if [[ "$line" =~ "-" ]]; then
            local left="${line%%-*}"
            local right="${line##*-}"
            local remove=()

            # Attempt to merge ranges
            # If successful merge, add to `valids`; then, remove original ranges
            # Loop through all current ranges in `valid`; see if any can be merged
            for ((i=0; i < "${#valids[@]}"; i++)); do
                local low="${valids[$i]%%-*}"
                local high="${valids[$i]##*-}"

                # Check if `$left` is between `valids`
                if ((low <= left)) && ((left <= high)); then
                    left="$low"
                fi

                # Check if `$right` is between `valids`
                if ((low <= right)) && ((right <= high)); then
                    right="$high"
                fi

                # If either changes, add the `$i` so it can be removed
                if ((left == low)) || ((right == high)); then
                    remove+=("$i")
                fi
            done

            # If any IDs in `remove`, unset them
            for id in "${remove[@]}"; do
                unset valids[$id]
            done

            # Reorder the `valids` array
            valids=(${valids[@]})

            # Empty the `remove` array
            remove=()

            # Once the checks complete, push the range to `valids`
            valids+=("${left}-${right}")
        elif [[ "$line" == "" ]]; then
            continue
        else
            # Check if the number is within any valid ranges
            for ((i=0; i < "${#valids[@]}"; i++)); do
                valid="${valids[$i]}"
                left="${valid%%-*}"
                right="${valid##*-}"

                if ((left <= line)) && ((line <= right)); then
                    sum="$((sum + 1))"
                    break
                fi
            done
        fi
    done < "$INPUT_FILE"

    echo "2025 D05 P1 = $sum"
}

part_two() {
    local valids=()
    local sum=0

    # Get all ranges into an array (`valids`)
    while read -r line; do
        if [[ "$line" =~ "-" ]]; then
            valids+=("$line")
        else
            continue
        fi
    done < "$INPUT_FILE"

    # Attempt to merge ranges
    # If successful merge, add to `valids`; then, remove original ranges
    for range in "${valids[@]}"; do
        local left="${range%%-*}"
        local right="${range##*-}"
        local remove=()

        # Loop through all current ranges in `valid`; see if any can be merged
        for ((i=0; i < "${#valids[@]}"; i++)); do
            local low="${valids[$i]%%-*}"
            local high="${valids[$i]##*-}"

            # Check if `$left` is between `valids`
            if ((low <= left)) && ((left <= high)); then
                left="$low"
            fi

            # Check if `$right` is between `valids`
            if ((low <= right)) && ((right <= high)); then
                right="$high"
            fi

            # If either changes, add the `$i` so it can be removed
            if ((left == low)) || ((right == high)); then
                remove+=("$i")
            fi
        done

        # If any IDs in `remove`, unset them
        for id in "${remove[@]}"; do
            unset valids[$id]
        done

        # Reorder the `valids` array
        valids=(${valids[@]})

        # Empty the `remove` array
        remove=()

        # Once the checks complete, push the range to `valids`
        valids+=("${left}-${right}")
    done

    # Loop through merged ranges to sum the diffs (inclusive)
    for range in "${valids[@]}"; do
        local low="${range%%-*}"
        local high="${range##*-}"
        local diff_inclu="$((high - low + 1))"

        sum="$((sum + diff_inclu))"
    done

    echo "2025 D05 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
