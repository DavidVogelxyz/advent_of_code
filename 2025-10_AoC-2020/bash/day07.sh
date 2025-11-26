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

recursive_search() {
    local term="${1#* }"
    local count_bag=${1// *}
    local count_inside=0
    local count_recurse=0

    while read -r line; do
        if [[ "$line" =~ ^$term ]]; then
            line=(${line##*contain })

            for ((i=0; i < "${#line[@]}"; i+=4)); do
                count_recurse="$(recursive_search "${line[$i]} ${line[((i + 1))]} ${line[((i + 2))]}")"
                count_inside="$((count_inside + count_recurse))"
            done
        fi
    done < "$INPUT_FILE"

    echo $((count_bag + (count_bag * count_inside)))
}

part_two() {
    local bags_total="$(recursive_search "1 shiny gold")"

    echo "The shiny gold bag MUST CONTAIN $((bags_total - 1)) bags."
}

main() {
    # PART ONE
    #part_one

    # PART TWO
    part_two
}

main
