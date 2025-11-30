def part_one(arr):
    sum = 0

    for line in arr:
        # Get chunks
        chunks = line.split()
        numbers = chunks[0]
        policy = chunks[1]
        string = chunks[2]

        # Parse chunks
        bounds = numbers.split("-")
        slice = policy.split(":")

        # Get the low bound
        low = int(bounds[0])

        # Get the high bound
        high = int(bounds[1])

        # Get the char of interest
        c = slice[0]

        # Count # of char of interest in string
        count = int(string.count(c))

        if low <= count <= high:
            sum += 1

    print(f"2020 D02 P1 = {sum}")


def part_two(arr):
    sum = 0

    for line in arr:
        # Get chunks
        chunks = line.split()
        numbers = chunks[0]
        policy = chunks[1]
        string = chunks[2]

        # Parse chunks
        bounds = numbers.split("-")
        slice = policy.split(":")

        # Get the low bound
        low = int(bounds[0])
        lo = string[low - 1:low]

        # Get the high bound
        high = int(bounds[1])
        hi = string[high - 1:high]

        # Get the char of interest
        c = slice[0]

        # Skip if "low bound" and "high bound" are ever the same
        if lo == hi:
            continue

        if c == lo:
            sum += 1
        elif c == hi:
            sum += 1

    print(f"2020 D02 P2 = {sum}")


def main():
    with open("../inputs/d02.txt", "r") as file:
        arr = [line.strip() for line in file]

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
