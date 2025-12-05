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

            for ((i=0; i < "${#valids[@]}"; i++)); do
                range="${valids[$i]}"
                local low="${range%%-*}"
                local high="${range##*-}"

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

            # Once the checks complete, push the range to `valids`
            valids+=("${left}-${right}")

            # If any IDs in `remove`, unset them
            for id in "${remove[@]}"; do
                unset valids[$id]
            done

            # Reorder the `valids` array
            valids=(${valids[@]})

            # Empty the `remove` array
            remove=()
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

main() {
    # PART ONE
    part_one
}

main
