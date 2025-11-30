def part_one(arr):
    sum = 0

    for line in arr:
        line = line.split("x")

        length = int(line[0])
        width = int(line[1])
        height = int(line[2])

        lw = length * width
        wh = width * height
        hl = height * length

        area = 2 * (lw + wh + hl)

        if lw < wh and lw < hl:
            area = area + lw
        elif wh < hl:
            area = area + wh
        else:
            area = area + hl

        sum = sum + area

    print(f"2015 D02 P1 = {sum}")


def part_two(arr):
    sum = 0

    for line in arr:
        line = line.split("x")

        length = int(line[0])
        width = int(line[1])
        height = int(line[2])

        wrap = 0
        bow = 0

        if length > width and length > height:
            wrap = 2 * (width + height)
        elif width > height:
            wrap = 2 * (length + height)
        else:
            wrap = 2 * (length + width)

        bow = length * width * height

        sum = sum + wrap + bow

    print(f"2015 D02 P2 = {sum}")


def main():
    with open("../inputs/d02.txt", "r") as file:
        arr = file.read().strip("\n\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
