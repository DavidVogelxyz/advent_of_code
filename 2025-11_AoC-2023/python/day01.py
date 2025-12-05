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


def main():
    with open("../inputs/d01.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)


if __name__ == "__main__":
    main()
