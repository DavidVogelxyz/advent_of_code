def part_one(arr):
    sum = 0

    for c in arr:
        if c == "(":
            sum = sum + 1
        elif c == ")":
            sum = sum - 1

    print(f"2015 D01 P1 = {sum}")


def part_two(arr):
    sum = 0
    count = 0

    for c in arr:
        # According to AoC, `count` should start at `1`, not `0`.
        count += 1

        if c == "(":
            sum = sum + 1
        elif c == ")":
            sum = sum - 1

        if sum == -1:
            print(f"2015 D01 P2 = {count}")
            return


def main():
    with open("../inputs/d01.txt", "r") as file:
        arr = file.read().strip("\n\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
