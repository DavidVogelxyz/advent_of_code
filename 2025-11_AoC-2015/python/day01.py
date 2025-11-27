def part_one(arr):
    sum = 0

    for c in arr:
        if c == "(":
            sum = sum + 1
        elif c == ")":
            sum = sum - 1

    print(f"Santa will arrive on floor #{sum}.")


def part_two(arr):
    sum = 0
    count = 0

    for c in arr:
        count += 1

        if c == "(":
            sum = sum + 1
        elif c == ")":
            sum = sum - 1

        if sum == -1:
            # According to AoC, if the first character was a `)`, that would be position `1`, not `0`.
            print (f"The position of the first character that causes Santa to arrive at floor `-1` is position {count}.")
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
