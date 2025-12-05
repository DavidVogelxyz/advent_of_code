def part_one(arr):
    valids = []
    sum = 0

    for line in arr:
        if line.__contains__("-"):
            valids += [line]
        elif line == "":
            continue
        else:
            line = int(line)

            for bounds in valids:
                nums = bounds.split("-")
                left = int(nums[0])
                right = int(nums[1])

                if left <= line and line <= right:
                    sum += 1
                    break

    print(f"2025 D05 P1 = {sum}")


def part_two(arr):
    valids = []
    sum = 0

    for line in arr:
        if line.__contains__("-"):
            nums = line.split("-")
            left = int(nums[0])
            right = int(nums[1])

            for num in range(left, right + 1):
                valids += [num]
        else:
            continue

    sum = len(valids)

    print(f"2025 D05 P2 = {sum}")


def main():
    with open("../inputs/d05.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
