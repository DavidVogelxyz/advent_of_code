def day_two_part_one(arr):
    sum = 0

    for line in arr:
        chunks = line.split()

        # Parse string
        numbers = chunks[0]
        bounds = numbers.split("-")
        policy = chunks[1]
        string = chunks[2]
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

    return sum


def main():
    with open("../inputs/d2.txt", "r") as file:
        arr = [line.strip() for line in file]

    sum = day_two_part_one(arr)

    print(f"The sum is {sum}")


if __name__ == "__main__":
    main()
