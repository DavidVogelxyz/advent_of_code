use std::fs;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file.")
}

pub fn bubble_sort(arr: &mut Vec<i32>) -> &mut Vec<i32> {
    let mut _count: usize = 0;
    let mut new_len: usize;
    let mut len = arr.len();

    loop {
        new_len = 0;

        for i in 1.. len {
            if arr[i - 1] > arr[i] {
                arr.swap(i - 1, i);
                new_len = i;
            }
        }

        if new_len == 0 {
            break;
        }

        len = new_len;
        _count += 1;
    }

    arr
}

pub fn parse(input: String) -> i32 {
    let mut list_one = Vec::new();
    let mut list_two = Vec::new();

    for line in input.lines() {
        let line = line
            .trim()
            .split_whitespace()
            .collect::<Vec<_>>();

        let elem_one = line[0].parse::<i32>().unwrap();
        let elem_two = line[1].parse::<i32>().unwrap();

        list_one.push(elem_one);
        list_two.push(elem_two);
    }

    // sort the lines
    // used bubble sort because "let list_one = list_one.sort();" wasn't working
    let list_one = bubble_sort(&mut list_one).to_owned();
    let list_two = bubble_sort(&mut list_two).to_owned();

    //println!("{:?}", list_one);
    //println!("{:?}", list_two);

    let mut count = 0;
    let mut sum = 0;
    let mut one_iter = list_one.iter();
    let mut two_iter = list_two.iter();

    loop {
        if count >= list_one.len() {
            break
        }

        let one = one_iter.next().expect("num");
        let two = two_iter.next().expect("num");

        let mut diff = one - two;

        //println!("{}", diff);

        if diff < 0 {
            diff *= -1;
        }

        //println!("{}", diff);

        sum += diff;

        count += 1;
    }

    return sum
}

pub fn day_one_part_one(file: &str) -> i32 {
    let contents = read_file(file);

    parse(contents)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_one_part_one_test() {
        let file = "../inputs/d1_test.txt";

        assert_eq!(11, day_one_part_one(file))
    }
}
