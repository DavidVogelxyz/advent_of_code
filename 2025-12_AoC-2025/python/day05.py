def part_one(arr):
    valids = []
    sum = 0

    for line in arr:
        if line.__contains__("-"):
            ranges = line.split("-")
            left = int(ranges[0])
            right = int(ranges[1])
            remove = []
            i = 0

            # Attempt to merge ranges
            # If merged, add to `valids`; then, remove original ranges
            # Loop through all ranges in `valid`; see if any can be merged
            for valid in valids:
                valid = valid.split("-")
                low = int(valid[0])
                high = int(valid[1])

                # Check if `$left` is between `valids`
                if low <= left and left <= high:
                    left = low

                # Check if `$right` is between `valids`
                if low <= right and right <= high:
                    right = high

                # If either changes, add the `$i` so it can be removed
                if left == low or right == high:
                    remove += [i]

                i += 1

            # If any IDs in `remove`, unset them
            while len(remove) > 0:
                i = len(remove) - 1
                del valids[remove[i]]
                del remove[i]

            # Empty the `remove` array
            remove = []

            # Once the checks complete, push the range to `valids`
            valids += [f"{left}-{right}"]
        elif line == "":
            continue
        else:
            value = int(line)

            # Check if the number is within any valid ranges
            for valid in valids:
                valid = valid.split("-")
                low = int(valid[0])
                high = int(valid[1])

                if low <= value and value <= high:
                    sum += 1
                    break

    print(f"2025 D05 P1 = {sum}")


def main():
    with open("../inputs/d05.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)


if __name__ == "__main__":
    main()
