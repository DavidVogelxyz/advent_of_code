def part_one(arr):
    sum = 0

    for line in arr:
        nums = []

        for char in line:
            if char.isdigit():
                nums += [int(char)]

        new_num = ""
        new_num += str(nums[0])
        new_num += str(nums[-1])

        sum += int(new_num)

    print(f"2023 D01 P1 = {sum}")


def part_two(arr):
    sum = 0

    for line in arr:
        nums = []

        line = line.replace("one", "o1e")
        line = line.replace("two", "t2e")
        line = line.replace("three", "t3e")
        line = line.replace("four", "f4r")
        line = line.replace("five", "f5e")
        line = line.replace("six", "s6x")
        line = line.replace("seven", "s7n")
        line = line.replace("eight", "e8t")
        line = line.replace("nine", "n9e")

        for char in line:
            if char.isdigit():
                nums += [int(char)]

        new_num = ""
        new_num += str(nums[0])
        new_num += str(nums[-1])

        sum += int(new_num)

    print(f"2023 D01 P2 = {sum}")


def main():
    with open("../inputs/d01.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
