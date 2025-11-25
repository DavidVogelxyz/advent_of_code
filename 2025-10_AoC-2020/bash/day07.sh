#!/usr/bin/env bash

INPUT_FILE="../inputs/d07.txt"

look_for_things() {
    local search_term=("$@")

    while read -r line; do
        local outer="${line%% bags contain*}"
        local inner="${line##*bags contain }"

        for term in "${search_term[@]}"; do
            # If `$inner` contains the search term
            # And, the array doesn't already contain `$outer`
            # Then, add `$outer` to the `containers` hashmap
            if [[ "$inner" =~ "$term" ]] && ! [[ "${containers[@]}" =~ "$outer" ]] ; then
                containers["$outer"]+="$outer"
            fi
        done
    done < "$INPUT_FILE"
}

part_one() {
    declare -A containers
    local sum="${#containers[@]}"
    local check=0

    # First pass through the input
    look_for_things "shiny gold"
    sum="${#containers[@]}"

    # Keep recursing until no changes are made to the `containers` hashmap
    while ((sum != check)); do
        check="$sum"
        look_for_things "${containers[@]}"
        sum="${#containers[@]}"
    done

    echo "${sum} bags could (potentially) contain a shiny gold bag."
}

main() {
    # PART ONE
    part_one
}

main
