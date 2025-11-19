def binary_search(string):
    count = int(len(string))
    lo = 0
    hi = 2 ** count - 1
    last_char = count - 1
    i = 0

    while i < last_char:
        c = string[i:i + 1]

        half = (hi - lo + 1) / 2

        if c == "F" or c == "L":
            hi = hi - half
        elif c == "B" or c == "R":
            lo = lo + half

        i += 1

    c = string[i:i + 1]

    if c == "F" or c == "L":
        result = lo
    elif c == "B" or c == "R":
        result = hi

    return result


def day_five_part_one(arr):
    highest = 0

    for bsp in arr:
        row = bsp[0:7]
        col = bsp[7:10]

        row = binary_search(row)
        col = binary_search(col)

        seat_ID = 8 * row + col

        if highest < seat_ID:
            highest = seat_ID

    print(f"The highest seat ID is {highest}.")


def main():
    with open("../inputs/d05.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    day_five_part_one(arr)


if __name__ == "__main__":
    main()
