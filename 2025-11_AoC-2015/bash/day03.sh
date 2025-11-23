#!/usr/bin/env bash

INPUT_FILE="../inputs/d03.txt"

move() {
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
    while read -r line; do
        local count="${#line}"
        local x=0
        local y=0
        declare -A visited
        visited["$x, $y"]=1
        local sum=1

        for ((i=0; i < count; i++)); do
            local c="${line:i:1}"

            move "$c"

            if [[ "${visited["$x, $y"]}" == 1 ]]; then
                continue
            else
                visited["$x, $y"]=1
                sum="$((sum + 1))"
            fi
        done

        echo "${sum} houses receive at least 1 present."
    done < "$INPUT_FILE"
}

main() {
    # PART ONE
    part_one
}

main
