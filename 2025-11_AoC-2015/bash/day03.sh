#!/usr/bin/env bash

INPUT_FILE="../inputs/d03.txt"

move_santa() {
    local c="$1"

    case "$c" in
        "^")
            y="$((y+1))";;
        "v")
            y="$((y-1))";;
        ">")
            x="$((x+1))";;
        "<")
            x="$((x-1))";;
    esac
}

part_one() {
    local x=0
    local y=0
    declare -A visited
    visited["$x, $y"]=1
    local sum=1

    while read -r line; do
        local count="${#line}"

        for ((i=0; i < count; i++)); do
            local c="${line:i:1}"

            move_santa "$c"

            if [[ "${visited["$x, $y"]}" == 1 ]]; then
                continue
            else
                visited["$x, $y"]=1
                sum="$((sum + 1))"
            fi
        done
    done < "$INPUT_FILE"

    echo "2015 D03 P1 = $sum"
}

move_robo() {
    local c="$1"

    case "$c" in
        "^")
            s="$((s+1))";;
        "v")
            s="$((s-1))";;
        ">")
            r="$((r+1))";;
        "<")
            r="$((r-1))";;
    esac
}

part_two() {
    local x=0
    local y=0
    local r=0
    local s=0
    declare -A visited
    visited["$x, $y"]=1
    local sum=1

    while read -r line; do
        local count="${#line}"

        for ((i=0; i < count; i++)); do
            local c="${line:i:1}"

            if ((i % 2 == 0)); then
                move_santa "$c"

                if [[ "${visited["$x, $y"]}" == 1 ]]; then
                    continue
                else
                    visited["$x, $y"]=1
                    sum="$((sum + 1))"
                fi
            else
                move_robo "$c"

                if [[ "${visited["$r, $s"]}" == 1 ]]; then
                    continue
                else
                    visited["$r, $s"]=1
                    sum="$((sum + 1))"
                fi
            fi
        done
    done < "$INPUT_FILE"

    echo "2015 D03 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
