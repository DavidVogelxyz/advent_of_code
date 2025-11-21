def parse_line_part_one(line, group):
    count = int(len(line))
    i = 0

    while i < count:
        letter = line[i:i + 1]

        # if the `group` array does not contain the letter, add it
        if group.__contains__(letter) == False:
            group += [letter]

        i += 1

    return group


def day_six_part_one(arr):
    group = []
    sum = 0

    for line in arr:
        if line != "":
            group = parse_line_part_one(line, group)
        else:
            count = int(len(group))
            sum = sum + count
            group = []

    count = int(len(group))
    sum = sum + count

    print(f"The sum is {sum}.")


def main():
    with open("../inputs/d06.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    day_six_part_one(arr)


if __name__ == "__main__":
    main()
