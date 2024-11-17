use std::fs;

pub fn read_file() -> String {
    let file_path = "inputs/d1_input.txt";

    fs::read_to_string(file_path)
        .expect("Should be able to read file.")
}

pub fn parse_line_part_one(contents: String) -> Vec<u32> {
    let mut nums: Vec<u32> = Vec::new();

    for line in contents.lines() {
        let numbers = only_numbers(&line);
        let number = first_and_last(&numbers);
        let number: u32 = number.trim().parse::<u32>().unwrap();

        nums.push(number);
    }

    return nums
}

pub fn parse_line_part_two(contents: String) -> Vec<u32> {
    let mut nums: Vec<u32> = Vec::new();

    for line in contents.lines() {
        let line = letters_to_digits(&line);
        let numbers = only_numbers(&line);
        let number = first_and_last(&numbers);
        let number: u32 = number.trim().parse::<u32>().unwrap();

        nums.push(number);
    }

    return nums
}

pub fn letters_to_digits(line: &str) -> String {
    line
        .replace("one", "o1e")
        .replace("two", "t2o")
        .replace("three", "t3e")
        .replace("four", "f4r")
        .replace("five", "f5e")
        .replace("six", "s6x")
        .replace("seven", "s7n")
        .replace("eight", "e8t")
        .replace("nine", "n9e")
        .to_string()
}

pub fn only_numbers(line: &str) -> String {
    line
        .chars()
        .filter(|x| x.is_numeric())
        .collect()
}

pub fn first_and_last(numbers: &str) -> String {
    let first: &str = &numbers[0..1];
    let r = numbers.len();
    let l = r - 1;
    let last: &str = &numbers[l..r];

    format!("{first}{last}")
}

pub fn sum_numbers(nums: Vec<u32>) -> u32 {
    nums
        .iter()
        .sum()
}

pub fn day_one_part_one() -> u32 {
    let contents = read_file();
    let nums = parse_line_part_one(contents);
    sum_numbers(nums)
}

pub fn day_one_part_two() -> u32 {
    let contents = read_file();
    let nums = parse_line_part_two(contents);
    sum_numbers(nums)
}
