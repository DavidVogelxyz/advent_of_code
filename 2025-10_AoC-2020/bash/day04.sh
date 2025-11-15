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

eye_colors=(
    "amb"
    "blu"
    "brn"
    "gry"
    "grn"
    "hzl"
    "oth"
)

parse_line_part_one() {
    local arr=($1)

    for item in "${arr[@]}"; do
        local field="${item%%:*}"
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
    local passport=()
    local pass_num=1
    local sum=0
    local valid=true

    while read -r line; do
        if ! [[ "$line" == "" ]]; then
            parse_line_part_one "$line"
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

parse_line_part_two() {
    local arr=($1)

    for item in "${arr[@]}"; do
        # If the previous item was invalid, break out of `for` loop
        # This also avoids continuing after moving to a new line
        if [[ "$valid" == false ]]; then
            break
        fi

        local field="${item%%:*}"
        local value="${item##*:}"

        case "$field" in
            "byr")
                if (( value >= 1920 && value <= 2002 )); then
                    passport+=("$field")
                else
                    valid=false
                fi;;
            "iyr")
                if (( value >= 2010 && value <= 2020 )); then
                    passport+=("$field")
                else
                    valid=false
                fi;;
            "eyr")
                if (( value >= 2020 && value <= 2030 )); then
                    passport+=("$field")
                else
                    valid=false
                fi;;
            "hgt")
                if [[ "$value" == *"cm" ]]; then
                    # remove the units
                    local cm="${value%%cm}"

                    # check the centimeter range
                    if (( cm >= 150 && cm <= 193 )); then
                        passport+=("$field")
                    else
                        valid=false
                    fi
                elif [[ "$value" == *"in" ]]; then
                    # remove the units
                    local in="${value%%in}"

                    # check the inches range
                    if (( in >= 59 && in <= 76 )); then
                        passport+=("$field")
                    else
                        valid=false
                    fi
                else
                    valid=false
                fi;;
            "hcl")
                # Remove strings that aren't hex values starting with `#`
                if [[ "$value" =~ ^#[0-9a-f]+$ ]]; then
                    # Prefix `0x` to the hex string, and remove the `#`
                    value="0x${value###}"
                else
                    valid=false
                    break
                fi

                # Process the hex string (this also confirms 6 digits)
                if (( value >= 0x000000 && value <= 0xffffff )); then
                    passport+=("$field")
                else
                    valid=false
                fi;;
            "ecl")
                if [[ "${eye_colors[*]}" =~ "$value" ]]; then
                    passport+=("$field")
                else
                    valid=false
                fi;;
            "pid")
                # If `pid` has characters that aren't numbers, break
                if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                    valid=false
                    break
                fi

                digits_in_pid="${#value}"

                # `pid` must contain 9 digits
                if (( digits_in_pid == 9 )); then
                    passport+=("$field")
                else
                    valid=false
                fi;;
            "cid")
                continue;;
        esac
    done
}

day_four_part_two() {
    local passport=()
    local pass_num=1
    local sum=0
    local valid=true

    while read -r line; do
        if ! [[ "$line" == "" ]]; then
            parse_line_part_two "$line"
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
    # PART ONE
    #day_four_part_one

    # PART TWO
    day_four_part_two
}

main
