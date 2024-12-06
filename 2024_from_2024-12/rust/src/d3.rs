use std::fs;
// uses `regex = "1.8.1"`
use regex::Regex;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file")
}

pub fn search_part_one(input: String) -> i32 {
    let mut sum = 0;
    let reg = Regex::new(r"mul\(([0-9]{1,3},([0-9]){1,3})\)").unwrap();

    for (_, [nums, _ignore]) in reg.captures_iter(&input).map(|x| x.extract()) {
        let num_pair = nums.split(",").collect::<Vec<_>>();
        let num1 = num_pair[0].parse::<i32>().unwrap();
        let num2 = num_pair[1].parse::<i32>().unwrap();

        sum += num1 * num2;
    }

    sum
}

pub fn search_part_two(input: String) -> i32 {
    let mut sum = 0;
    let reg_mul = Regex::new(r"mul\(([0-9]{1,3},([0-9]){1,3})\)").unwrap();
    let reg_do = Regex::new(r"do\(\)$").unwrap();
    let reg_dont = Regex::new(r"don't\(\)$").unwrap();
    let mut enabled = true;

    let input = input.replace(")", ")\n");

    for line in input.lines() {
        if reg_do.is_match(&line) {
            enabled = true;
        } else if reg_dont.is_match(&line) {
            enabled = false;
        } else if reg_mul.is_match(&line) && enabled == true {
            for (_, [nums, _ignore]) in reg_mul.captures_iter(&line).map(|x| x.extract()) {
                let num_pair = nums.split(",").collect::<Vec<_>>();
                let num1 = num_pair[0].parse::<i32>().unwrap();
                let num2 = num_pair[1].parse::<i32>().unwrap();

                sum += num1 * num2;
            }
        }
    }

    sum
}

pub fn day_three_part_one(file: &str) -> i32 {
    let input = read_file(file);

    search_part_one(input)
}

pub fn day_three_part_two(file: &str) -> i32 {
    let input = read_file(file);

    search_part_two(input)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_three_part_one_test() {
        let file = "../inputs/d3p1_test.txt";

        assert_eq!(161, day_three_part_one(file));
    }

    #[test]
    fn day_three_part_two_test() {
        let file = "../inputs/d3p2_test.txt";

        assert_eq!(48, day_three_part_two(file));
    }
}
