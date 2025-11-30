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

    echo "2015 D02 P1 = $sum"
}

part_two() {
    local sum=0

    while IFS="x" read -r l w h; do
        local wrap=0

        if ((l > w)) && ((l > h)); then
            wrap="$((2 * (w + h)))"
        elif ((w > h)); then
            wrap="$((2 * (l + h)))"
        else
            wrap="$((2 * (l + w)))"
        fi

        local bow="$((l * w * h))"

        sum="$((sum + wrap + bow))"
    done < "$INPUT_FILE"

    echo "2015 D02 P2 = $sum"
}

main() {
    # PART ONE
    part_one

    # PART TWO
    part_two
}

main
