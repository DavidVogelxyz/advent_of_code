must_contain = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid"
]

eye_colors = [
    "amb",
    "blu",
    "brn",
    "gry",
    "grn",
    "hzl",
    "oth"
]


def parse_line_part_one(line, passport):
    arr = line.split()

    for item in arr:
        field = item.split(":")[0]
        passport += [field]

    return passport


def check_passport(passport, sum):
    if set(must_contain).issubset(set(passport)):
        sum += 1

    return sum


def part_one(arr):
    passport = []
    pass_num = int(1)
    sum = 0

    for line in arr:
        if line != "":
            passport = parse_line_part_one(line, passport)
        else:
            sum = check_passport(passport, sum)
            passport = []
            pass_num += 1

    # Check the last passport
    sum = check_passport(passport, sum)

    print(f"2020 D04 P1 = {sum}")


def parse_line_part_two(line, passport, valid):
    arr = line.split()

    for item in arr:
        # If the previous item was invalid, break out of `for` loop
        # This also avoids continuing after moving to a new line
        if valid is False:
            return passport, valid

        field = item.split(":")[0]
        value = item.split(":")[1]

        match field:
            case "byr":
                value = int(value)

                if value >= 1920 and value <= 2002:
                    passport += [field]
                else:
                    valid = False
            case "iyr":
                value = int(value)

                if value >= 2010 and value <= 2020:
                    passport += [field]
                else:
                    valid = False
            case "eyr":
                value = int(value)

                if value >= 2020 and value <= 2030:
                    passport += [field]
                else:
                    valid = False
            case "hgt":
                if value.__contains__("cm"):
                    # remove the units
                    value = int(value.split("cm")[0])

                    # check the centimeter range
                    if value >= 150 and value <= 193:
                        passport += [field]
                    else:
                        valid = False
                elif value.__contains__("in"):
                    # remove the units
                    value = int(value.split("in")[0])

                    # check the inches range
                    if value >= 59 and value <= 76:
                        passport += [field]
                    else:
                        valid = False
                else:
                    valid = False
            case "hcl":
                # Remove strings that don't start with `#`
                if value.startswith("#"):
                    value = value.replace("#", "")
                else:
                    valid = False
                    break

                digits_in_hcl = int(len(value))

                # Confirm only 6 digits in the string
                if digits_in_hcl != 6:
                    valid = False
                    break

                # Remove strings that aren't hex values
                if int(value, 16):
                    passport += [field]
                else:
                    valid = False
            case "ecl":
                if eye_colors.__contains__(value):
                    passport += [field]
                else:
                    valid = False
            case "pid":
                # If `pid` has any letters, break
                if value.upper().isupper() is True:
                    valid = False
                    break

                digits_in_pid = int(len(value))

                # `pid` must contain 9 digits
                if digits_in_pid == 9:
                    passport += [field]
                else:
                    valid = False
            case "cid":
                continue

    return passport, valid


def part_two(arr):
    passport = []
    pass_num = int(1)
    sum = 0
    valid = True

    for line in arr:
        if line != "":
            passport, valid = parse_line_part_two(line, passport, valid)
        else:
            sum = check_passport(passport, sum)
            passport = []
            pass_num += 1
            valid = True

    # Check the last passport
    sum = check_passport(passport, sum)

    print(f"2020 D04 P2 = {sum}")


def main():
    with open("../inputs/d04.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
