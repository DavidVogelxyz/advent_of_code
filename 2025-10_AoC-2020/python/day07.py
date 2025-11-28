def search(arr, bags, search_term):
    new = []

    for line in arr:
        chunks = line.split(" ")
        container = f"{chunks[0]} {chunks[1]}"

        for term in search_term:
            if line.__contains__(term):
                if container not in bags:
                    new.append(container)
                    bags.append(container)

    return bags, new


def part_one(arr):
    new = []
    bags = []
    bags, new = search(arr, bags, [" shiny gold"])

    while len(new) != 0:
        bags, new = search(arr, bags, new)

    print(f"{len(bags)} bags could (potentially) contain a shiny gold bag.")


def main():
    with open("../inputs/d07.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)


if __name__ == "__main__":
    main()
