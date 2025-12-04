def part_one(arr):
    sum = 0

    for line in arr:
        nums = []
        count = len(line)
        num_largest = 0
        pos_largest = 0
        curr_num = 0
        next_pos = 0

        # To get the 2 numbers, leave 1 in reserve
        i = 1

        while i >= 0:
            j = next_pos

            while j < count - i:
                curr_num = int(line[j:j+1])

                if num_largest < curr_num:
                    num_largest = curr_num
                    pos_largest = j

                j += 1

            nums += [str(num_largest)]
            num_largest = 0
            next_pos = pos_largest + 1
            i -= 1

        jolt = ""

        for num in nums:
            jolt += num

        sum = sum + int(jolt)

    print(f"2025 D03 P1 = {sum}")


def main():
    with open("../inputs/d03.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)


if __name__ == "__main__":
    main()
