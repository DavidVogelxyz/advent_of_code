def move(x, y, c):
    match c:
        case "^":
            y += 1
        case "v":
            y -= 1
        case ">":
            x += 1
        case "<":
            x -= 1

    return x, y


def part_one(arr):
    x = 0
    y = 0
    coords = x, y
    visited = []
    visited.append(coords)

    for line in arr:
        for c in line:
            x, y = move(x, y, c)
            coords = x, y

            if visited.__contains__(coords):
                continue
            else:
                visited.append(coords)

    print(f"{len(visited)} houses receive at least 1 present.")


def part_two(arr):
    x = 0
    y = 0
    r = 0
    s = 0
    coords = x, y
    visited = []
    visited.append(coords)
    count = 0

    for line in arr:
        for c in line:
            if count % 2 == 0:
                x, y = move(x, y, c)
                coords = x, y
            else:
                r, s = move(r, s, c)
                coords = r, s

            count += 1

            if visited.__contains__(coords):
                continue
            else:
                visited.append(coords)

    print(f"{len(visited)} houses receive at least 1 present.")


def main():
    with open("../inputs/d03.txt", "r") as file:
        arr = file.read().strip("\n\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
