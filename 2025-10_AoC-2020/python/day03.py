def day_three_part_one(arr):
    sum = 0

    # The first character in `arr` is position `0`
    x = 0

    # The first line is "line 1"
    y = 1

    # Since the lines are all the same char length, get the length of a line
    length = int(len(arr[0]))

    for line in arr:
        # Skip the first line; treat the other lines
        if y != 1:
            # If the character is a tree, add to total
            if line[x] == "#":
                sum += 1

        # Move 3 positions to the right
        x += 3

        # Loop back over line, if necessary
        if x > length - 1:
            x = x - length

        # Move the `y` counter down a line
        y += 1

    return sum


def main():
    with open("../inputs/d03.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    sum = day_three_part_one(arr)

    print(f"{sum} trees were hit while travelling.")


if __name__ == "__main__":
    main()
