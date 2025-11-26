#!/usr/bin/env bash

INPUT_FILE="../inputs/d07.txt"

search() {
    local search_term=("$@")
    new=()

    while read -r line; do
        local container="${line// bag*}"

        for term in "${search_term[@]}"; do
            if [[ "$line" =~ "$term" ]]; then
                if ! [[ "${bags[@]}" =~ "$container" ]]; then
                    new+=("$container")
                    bags+=("$container")
                fi
            fi
        done
    done < "$INPUT_FILE"
}

part_one() {
    local new=()
    local bags=()
    search " shiny gold"

    while (("${#new[@]}" != 0 )); do
        search "${new[@]}"
    done

    echo "${#bags[@]} bags could (potentially) contain a shiny gold bag."
}

main() {
    # PART ONE
    part_one
}

main
