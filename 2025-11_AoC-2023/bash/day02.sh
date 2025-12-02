#!/usr/bin/env bash

INPUT_FILE="../inputs/d02.txt"

r_max=12
g_max=13
b_max=14

part_one() {
    local sum=0

    while read -r line; do
        local r=0
        local g=0
        local b=0

        local game_id="${line%%: *}"
        game_id="${game_id##* }"

        line="${line##*: }"

        for word in $line; do
            case "$word" in
                "red"*)
                    r="$((r + prev_word))";;
                "green"*)
                    g="$((g + prev_word))";;
                "blue"*)
                    b="$((b + prev_word))";;
            esac

            prev_word="$word"

            if [[ "$word" =~ ";" ]]; then
                if ((r > r_max)) || ((g > g_max)) || ((b > b_max)); then
                    continue
                else
                    r=0
                    g=0
                    b=0
                fi
            fi
        done

        if ((r <= r_max)) && ((g <= g_max)) && ((b <= b_max)); then
            sum="$((sum + game_id))"
        fi
    done < "$INPUT_FILE"

    echo "2023 D02 P1 = $sum"
}

part_two() {
    local sum=0

    while read -r line; do
        local r=0
        local g=0
        local b=0

        local game_id="${line%%: *}"
        game_id="${game_id##* }"

        line="${line##*: }"

        for word in $line; do
            case "$word" in
                "red"*)
                    if ((r < prev_word)); then
                        r="$prev_word"
                    fi;;
                "green"*)
                    if ((g < prev_word)); then
                        g="$prev_word"
                    fi;;
                "blue"*)
                    if ((b < prev_word)); then
                        b="$prev_word"
                    fi;;
            esac

            prev_word="$word"
        done

        power="$((r * g * b))"
        sum="$((sum + power))"
    done < "$INPUT_FILE"

    echo "2023 D02 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
