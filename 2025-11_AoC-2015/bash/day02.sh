#!/usr/bin/env bash

INPUT_FILE="../inputs/d02.txt"

part_one() {
    local sum=0

    while IFS="x" read -r l w h; do
        local lw="$((l * w))"
        local wh="$((w * h))"
        local hl="$((h * l))"

        local area="$((2 * (lw + wh + hl)))"

        if ((lw < wh)) && ((lw < hl)); then
            area="$((area + lw))"
        elif ((wh < hl)); then
            area="$((area + wh))"
        else
            area="$((area + hl))"
        fi

        sum="$((sum + area))"
    done < "$INPUT_FILE"

    echo "The elves require ${sum} square feet of wrapping paper."
}

main() {
    # PART ONE
    part_one
}

main
