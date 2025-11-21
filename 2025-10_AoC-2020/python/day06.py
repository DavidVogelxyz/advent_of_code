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


def parse_line_part_two(line, group, person):
    count = int(len(line))
    person = person + 1

    if person == 1:
        i = 0

        while i < count:
            letter = line[i:i + 1]

            # if the `group` array does not contain the letter, add it
            if group.__contains__(letter) == False:
                group += [letter]

            i += 1
    else:
        count_group = int(len(group))
        j = count_group - 1

        while j >= 0:
            letter = group[j]

            if letter not in line:
                group.pop(j)

            j += -1

    return group, person


def day_six_part_two(arr):
    group = []
    person = 0
    sum = 0

    for line in arr:
        if line != "":
            group, person = parse_line_part_two(line, group, person)
        else:
            count = int(len(group))
            sum = sum + count
            group = []
            person = 0

    count = int(len(group))
    sum = sum + count

    print(f"The sum is {sum}.")


def main():
    with open("../inputs/d06.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    #day_six_part_one(arr)

    # PART TWO
    day_six_part_two(arr)


if __name__ == "__main__":
    main()
