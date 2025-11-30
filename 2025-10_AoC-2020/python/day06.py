def part_one(arr):
    sum = 0

    for group in arr:
        for letter in "abcdefghijklmnopqrstuvwxyz":
            if letter in group:
                sum = sum + 1

    print(f"2020 D06 P1 = {sum}")


def part_two(arr):
    sum = 0

    for group in arr:
        group = group.splitlines()
        check = set(group[0])

        for person in group:
            check = check & set(person)

        sum = sum + int(len(check))

    print(f"2020 D06 P2 = {sum}")


def main():
    with open("../inputs/d06.txt", "r") as file:
        arr = file.read().strip("\n").split("\n\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
