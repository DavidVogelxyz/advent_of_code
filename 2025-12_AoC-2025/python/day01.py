def part_one(arr):
    dial = 50
    sum = 0

    for line in arr:
        dir = line[0:1]
        dist = int(line[1:])

        if dir == "L":
            dial = dial - dist
        else:
            dial = dial + dist

        # Keep `dial` within 0-99; for values below 0
        while dial < 0:
            dial = dial + 100

        # Keep `dial` within 0-99; for values above 0
        while dial > 99:
            dial = dial - 100

        if dial == 0:
            sum = sum + 1

    print(f"2025 D01 P1 = {sum}")


def part_two(arr):
    dial = 50
    sum = 0

    for line in arr:
        dir = line[0:1]
        dist = int(line[1:])

        # Remove "double count" when starting at 0 and going left
        if dial == 0 and dir == "L":
            sum = sum - 1

        if dir == "L":
            dial = dial - dist
        else:
            dial = dial + dist

        # Keep `dial` within 0-99; for values below 0
        while dial < 0:
            dial = dial + 100
            sum = sum + 1

        # Keep `dial` within 0-99; for values above 0
        while dial > 99:
            # Remove "double count" when going from 100 to 0
            if dial == 100:
                sum = sum - 1

            dial = dial - 100
            sum = sum + 1

        if dial == 0:
            sum = sum + 1

    print(f"2025 D01 P2 = {sum}")


def main():
    with open("../inputs/d01.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
