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


def day_one_part_two_add(arr):
    i = 0

    while i < len(arr) - 2:
        j = i + 1

        while j < len(arr) - 1:
            k = i + 2

            while k < len(arr):
                if int(arr[i]) + int(arr[j]) + int(arr[k]) == 2020:
                    return arr[i], arr[j], arr[k]

                k += 1

            j += 1

        i += 1


def day_one_part_two_multiply(left, mid, right):
    product = int(left) * int(mid) * int(right)
    print(f"The product of {left}, {mid}, and {right} = {product}")


def main():
    with open("../inputs/d01.txt", "r") as file:
        arr = [line.strip() for line in file]

    #l, r = day_one_part_one_add(arr)
    #day_one_part_one_multiply(l, r)

    l, m, r = day_one_part_two_add(arr)
    day_one_part_two_multiply(l, m, r)


if __name__ == "__main__":
    main()
