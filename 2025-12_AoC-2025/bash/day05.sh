#!/usr/bin/env bash

INPUT_FILE="../inputs/d05.txt"

part_one() {
    local valids=()
    local sum=0

    while read -r line; do
        if [[ "$line" =~ "-" ]]; then
            valids+=("$line")
        elif [[ "$line" == "" ]]; then
            continue
        else
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
