#!/usr/bin/env bash

INPUT_FILE="../inputs/d04.txt"

must_contain=(
    "byr"
    "iyr"
    "eyr"
    "hgt"
    "hcl"
    "ecl"
    "pid"
)

parse_line() {
    arr=($1)

    for item in "${arr[@]}"; do
        field="${item%%:*}"
        passport+=("$field")
    done
}

check_passport() {
    while read -r item; do
        if ! [[ "${1}" =~ "$item" ]]; then
            valid=false
            break
        fi
    done < <(printf "%s\n" "${must_contain[@]}")
}

is_passport_valid() {
    if [[ "$valid" == true ]]; then
        sum=$((sum + 1))
    fi
}

day_four_part_one() {
    passport=()
    pass_num=1
    sum=0
    valid=true

    while read -r line; do
        if ! [[ "$line" == "" ]]; then
            parse_line "$line"
        else
            check_passport "${passport[*]}"
            is_passport_valid

            passport=()
            pass_num=$((pass_num + 1))
            valid=true
        fi
    done < "$INPUT_FILE"

    # Check the last passport
    check_passport "${passport[*]}"
    is_passport_valid

    echo "There are $sum valid passports!"
}

main() {
    day_four_part_one
}

main
