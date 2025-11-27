def part_one(arr):
    sum = 0

    for line in arr:
        line = line.split("x")

        l = int(line[0])
        w = int(line[1])
        h = int(line[2])

        lw = l * w
        wh = w * h
        hl = h * l

        area = 2 * (lw + wh + hl)

        if lw < wh and lw < hl:
            area = area + lw
        elif wh < hl:
            area = area + wh
        else:
            area = area + hl

        sum = sum + area

    print(f"The elves require {sum} square feet of wrapping paper.")


def part_two(arr):
    sum = 0

    for line in arr:
        line = line.split("x")

        l = int(line[0])
        w = int(line[1])
        h = int(line[2])

        wrap = 0
        bow = 0

        if l > w and l > h:
            wrap = 2 * (w + h)
        elif w > h:
            wrap = 2 * (l + h)
        else:
            wrap = 2 * (l + w)

        bow = l * w * h

        sum = sum + wrap + bow

    print(f"The elves require {sum} feet of ribbon.")


def main():
    with open("../inputs/d02.txt", "r") as file:
        arr = file.read().strip("\n\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
