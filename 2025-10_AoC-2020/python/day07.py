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

    print(f"2020 D07 P1 = {len(bags)}")


def recursive_search(arr, search_term):
    count_inside = 0
    count_recurse = 0

    search_words = search_term.split(" ")
    count_bag = search_words[0]
    bag = f"{search_words[1]} {search_words[2]}"
    for line in arr:
        if line.startswith(bag):
            bags_inside = line.split("contain ")
            bag_words = bags_inside[1].split(", ")

            for word in bag_words:
                bunks = word.split(" ")
                if bunks[0] == "no":
                    return int(count_bag)
                search_term = f"{bunks[0]} {bunks[1]} {bunks[2]}"
                count_recurse = int(recursive_search(arr, search_term))
                count_inside = int(count_inside) + int(count_recurse)

    total = int(count_bag) + (int(count_bag) * int(count_inside))
    return total


def part_two(arr):
    bags_total = recursive_search(arr, "1 shiny gold")

    print(f"2020 D07 P2 = {bags_total - 1}")


def main():
    with open("../inputs/d07.txt", "r") as file:
        arr = file.read().strip("\n").split("\n")

    # PART ONE
    part_one(arr)

    # PART TWO
    part_two(arr)


if __name__ == "__main__":
    main()
