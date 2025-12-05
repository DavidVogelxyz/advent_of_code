r_max = 12
g_max = 13
b_max = 14


def part_one(arr):
    sum = 0

    for line in arr:
        r = 0
        g = 0
        b = 0

        chunks = line.split(":")
        game_id = chunks[0].replace("Game ", "")

        records = chunks[1]
        prev_word = ""

        for word in records.split():
            if word.__contains__("red"):
                r += int(prev_word)
            elif word.__contains__("green"):
                g += int(prev_word)
            elif word.__contains__("blue"):
                b += int(prev_word)

            prev_word = word

            if word.__contains__(";"):
                if r > r_max or g > g_max or b > b_max:
                    continue
                else:
                    r = 0
                    g = 0
                    b = 0

        if r <= r_max and g <= g_max and b <= b_max:
            sum += int(game_id)

    print(f"2023 D02 P1 = {sum}")


def main():
    with open("../inputs/d02.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)


if __name__ == "__main__":
    main()
