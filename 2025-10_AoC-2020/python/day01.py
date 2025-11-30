def part_one(arr):
    i = 0

    while i < len(arr) - 1:
        j = i + 1

        while j < len(arr):
            if int(arr[i]) + int(arr[j]) == 2020:
                product = int(arr[i]) * int(arr[j])
                print(f"2020 D01 P1 = {product}")
                return

            j += 1

        i += 1


def part_two(arr):
    i = 0

    while i < len(arr) - 2:
        j = i + 1

        while j < len(arr) - 1:
            k = i + 2

            while k < len(arr):
                if int(arr[i]) + int(arr[j]) + int(arr[k]) == 2020:
                    product = int(arr[i]) * int(arr[j]) * int(arr[k])
                    print(f"2020 D01 P2 = {product}")
                    return

                k += 1

            j += 1

        i += 1


def main():
    with open("../inputs/d01.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
