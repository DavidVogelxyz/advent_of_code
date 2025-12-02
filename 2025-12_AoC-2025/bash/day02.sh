#!/usr/bin/env bash

INPUT_FILE="../inputs/d02.txt"

is_repetitive() {
    local string="$1"
    local length="${#string}"
    local mid="$((length / 2))"
    local left="${string:0:$mid}"
    local right="${string:$mid}"

    # If `$length` is odd, return as false
    if ((length % 2 == 1)); then
        return 1
    fi

    # Remove leading zeroes
    while [[ "$right" =~ ^0 ]]; do
        right="${right#0}"
    done

    if ((left == right)); then
        return
    else
        return 1
    fi
}

part_one() {
    local sum=0

    while read -r line; do
        IFS="," arr=($line)
        for range in "${arr[@]}"; do
            local lo="${range%%-*}"
            local hi="${range##*-}"

            for ((i=$lo; i<=$hi; i++)); do
                if is_repetitive "$i"; then
                    sum="$((sum + i))"
                fi
            done
        done
    done < "$INPUT_FILE"

    echo "2025 D02 P1 = $sum"
}

main() {
    # PART ONE
    part_one
}

main
