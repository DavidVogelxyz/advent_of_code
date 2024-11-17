use std::fs;

pub fn read_file() -> String {
    let file_path = "inputs/d1_input.txt";

    let contents = fs::read_to_string(file_path)
        .expect("Should be able to read file.");

    return contents
}

pub fn parse_line(contents: String) -> Vec<u32> {
    let mut nums: Vec<u32> = Vec::new();

    for line in contents.lines() {
        let numbers = only_numbers(&line);
        let number = first_and_last(&numbers);
        let number: u32 = number.trim().parse::<u32>().unwrap();

        nums.push(number);
    }

    return nums
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
    let nums = parse_line(contents);
    sum_numbers(nums)
}
