def travel(arr, right, down):
    sum = 0

    # The first character in `arr` is position `0`
    x = 0

    # The first line in `arr` is position `0`
    y = 0

    # Since the lines are all the same char length, get the line_len
    line_len = int(len(arr[0]))

    # get the total number of lines
    total_lines = int(len(arr))

    while y < total_lines:
        line = arr[y]

        # Skip the first line; treat the other lines
        if y != 0:
            # If the character is a tree, add to total
            if line[x] == "#":
                sum += 1

        # Move to the right
        x += right

        # Loop back over line, if necessary
        if x > line_len - 1:
            x = x - line_len

        # Move down
        y += down

    return sum


def part_one(arr):
    sum = travel(arr, 3, 1)

    print(f"2020 D03 P1 = {sum}")


def part_two(arr):
    n1 = travel(arr, 1, 1)
    n2 = travel(arr, 3, 1)
    n3 = travel(arr, 5, 1)
    n4 = travel(arr, 7, 1)
    n5 = travel(arr, 1, 2)

    product = n1 * n2 * n3 * n4 * n5

    print(f"2020 D03 P2 = {product}")


def main():
    with open("../inputs/d03.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
