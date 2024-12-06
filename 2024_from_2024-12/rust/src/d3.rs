use std::fs;
// uses `regex = "1.8.1"`
use regex::Regex;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file")
}

pub fn search(input: String) -> i32 {
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

pub fn day_three_part_one(file: &str) -> i32 {
    let input = read_file(file);

    search(input)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_three_part_one_test() {
        let file = "../inputs/d3_test.txt";

        assert_eq!(161, day_three_part_one(file));
    }
}
