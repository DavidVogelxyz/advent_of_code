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


def main():
    with open("../inputs/d05.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)


if __name__ == "__main__":
    main()
