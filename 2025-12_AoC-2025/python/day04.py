def part_one(arr):
    rows_total = len(arr)
    sum = 0
    num_adj_paper = 0
    row = 0

    # Read through rows (vertically)
    while row < rows_total:
        col = 0
        cols_total = len(arr[row])

        # Read through the cols (horizontally)
        while col < cols_total:
            char = arr[row][col]

            # Check the rolls of paper
            if char == "@":
                # `range(-1, 2)` results `[-1, 0. 1]`
                for row_offset in range(-1, 2):
                    # `range(-1, 2)` results `[-1, 0. 1]`
                    for col_offset in range(-1, 2):
                        # Skip the "current character"
                        if row_offset == 0 and col_offset == 0:
                            continue

                        adj_row = row + row_offset
                        adj_col = col + col_offset

                        # Skip if `$adj_row` is off map
                        if adj_row < 0 or adj_row >= rows_total:
                            continue

                        # Skip if `$adj_col` is off map
                        if adj_col < 0 or adj_col >= cols_total:
                            continue

                        adj_value = arr[adj_row][adj_col]

                        # If `$adj_value` is a "@", increase `$num_adj_paper`
                        if adj_value == "@":
                            num_adj_paper += 1

                # If `$num_adj_paper` is less than 4, increase `$sum`
                if num_adj_paper < 4:
                    sum += 1

                num_adj_paper = 0

            col += 1

        row += 1

    print(f"2025 D04 P1 = {sum}")


def part_two(arr):
    rows_total = len(arr)
    sum = 0
    num_adj_paper = 0
    new_sum = -1

    while new_sum != sum:
        new_map = []
        new_sum = sum
        row = 0

        # Read through rows (vertically)
        while row < rows_total:
            new_row = ""
            col = 0
            cols_total = len(arr[row])

            # Read through the cols (horizontally)
            while col < cols_total:
                char = arr[row][col]

                # Check the rolls of paper
                if char == "@":
                    # `range(-1, 2)` results `[-1, 0. 1]`
                    for row_offset in range(-1, 2):
                        # `range(-1, 2)` results `[-1, 0. 1]`
                        for col_offset in range(-1, 2):
                            # Skip the "current character"
                            if row_offset == 0 and col_offset == 0:
                                continue

                            adj_row = row + row_offset
                            adj_col = col + col_offset

                            # Skip if `$adj_row` is off map
                            if adj_row < 0 or adj_row >= rows_total:
                                continue

                            # Skip if `$adj_col` is off map
                            if adj_col < 0 or adj_col >= cols_total:
                                continue

                            adj_value = arr[adj_row][adj_col]

                            # If `$adj_value` is a "@", increase `$num_adj_paper`
                            if adj_value == "@":
                                num_adj_paper += 1

                    # If `$num_adj_paper` is less than 4, increase `$sum`
                    if num_adj_paper < 4:
                        sum += 1
                        char = "x"

                    num_adj_paper = 0

                # Add `$char` to the updated row
                new_row += char
                col += 1

            # Add `$new_row` to the updated map
            new_map += [new_row]
            row += 1

        # Change `$arr` to be the updated map
        arr = new_map

    print(f"2025 D04 P2 = {sum}")


def main():
    with open("../inputs/d04.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
