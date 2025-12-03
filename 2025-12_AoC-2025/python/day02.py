def is_repetitive_part_one(num):
    length = int(len(num))

    if length % 2 == 1:
        return False

    mid = int(length / 2)
    left = num[0:mid]
    right = num[mid:]

    if right.startswith("0"):
        return False

    if left == right:
        return True
    else:
        return False


def part_one(arr):
    sum = 0

    for line in arr:
        chunks = line.split(",")

        for chunk in chunks:
            if chunk == "":
                continue

            dunks = chunk.split("-")
            lo = int(dunks[0])
            hi = int(dunks[1])

            while lo < hi:
                if is_repetitive_part_one(str(lo)):
                    sum += lo

                lo += 1

    print(f"2025 D02 P1 = {sum}")


def is_repetitive_part_two(num):
    length = int(len(num))
    mid = int(length / 2)
    i = 1

    while i <= mid:
        left = num[0:i]
        sub = num.replace(left, "")

        if sub == "":
            return True

        i += 1

    return False


def part_two(arr):
    sum = 0

    for line in arr:
        chunks = line.split(",")

        for chunk in chunks:
            if chunk == "":
                continue

            dunks = chunk.split("-")
            lo = int(dunks[0])
            hi = int(dunks[1])

            while lo < hi:
                if is_repetitive_part_two(str(lo)):
                    sum += lo

                lo += 1

    print(f"2025 D02 P2 = {sum}")


def main():
    with open("../inputs/d02.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
