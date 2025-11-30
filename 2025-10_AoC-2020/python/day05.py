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


def part_one(arr):
    highest = 0

    for bsp in arr:
        row = bsp[0:7]
        col = bsp[7:10]

        row = int(binary_search(row))
        col = int(binary_search(col))

        seat_ID = 8 * row + col

        if highest < seat_ID:
            highest = seat_ID

    print(f"2020 D05 P1 = {highest}")


def bubble_sort(arr):
    count = int(len(arr))

    # default for `operated`
    operated = 1

    i = 0

    while i < count:
        operated = 0
        j = 0

        while j < (count - i - 1):
            if arr[j] > arr[j+1]:
                temp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = temp
                operated = 1

            j += 1

        if operated == 0:
            break

        i += 1

    return arr


def find_missing(arr):
    count = int(len(arr))
    last = 0
    i = 0

    while i < count:
        num = arr[i]

        if last == 0 or (last + 1) == num:
            last = num
            i += 1
        else:
            result = last + 1
            return result


def part_two(arr):
    seats = []

    for bsp in arr:
        row = bsp[0:7]
        col = bsp[7:10]

        row = int(binary_search(row))
        col = int(binary_search(col))

        seat_ID = 8 * row + col

        seats += [seat_ID]

    sorted = bubble_sort(seats)
    result = find_missing(sorted)

    print(f"2020 D05 P2 = {result}")


def main():
    with open("../inputs/d05.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
