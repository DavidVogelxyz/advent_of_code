must_contain = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid"
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


def day_four_part_one(arr):
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
            valid = True

    # Check the last passport
    sum = check_passport(passport, sum)

    print(f"There are {sum} valid passports.")


def main():
    with open("../inputs/d04.txt", "r") as file:
        arr = [line.strip() for line in file]

    day_four_part_one(arr)


if __name__ == "__main__":
    main()
