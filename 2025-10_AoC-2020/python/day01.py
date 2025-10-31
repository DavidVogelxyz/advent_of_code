def day_one_part_one_add(arr):
    i = 0

    while i < len(arr) - 1:
        j = i + 1

        while j < len(arr):
            if int(arr[i]) + int(arr[j]) == 2020:
                return arr[i], arr[j]

            j += 1

        i += 1


def day_one_part_one_multiply(left, right):
    product = int(left) * int(right)
    print(f"The product of {left} and {right} = {product}")


def main():
    with open("../inputs/d01.txt", "r") as file:
        arr = [line.strip() for line in file]

    l, r = day_one_part_one_add(arr)
    day_one_part_one_multiply(l, r)


if __name__ == "__main__":
    main()
