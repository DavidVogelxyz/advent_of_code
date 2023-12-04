use crate::day_one;
use std::error::Error;
use std::fs;

pub fn solve() -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string("src/day_one/input.txt")?;

    let v2 = day_one::filter_strings(contents);

    dbg!(day_one::sum_numbers(v2));

    Ok(())
}

pub fn filter_strings(contents: String) -> Vec<u32> {
    let mut results: Vec<u32> = Vec::new();

    for line in contents.lines() {
        let result = remove_letters(line);
        let result = modify_numbers(&result);

        let number: u32 = match result.trim().parse() {
            Ok(num) => num,
            Err(_) => 0,
        };

        results.push(number);
    }

    results
}

pub fn remove_letters(line: &str) -> String {
    line
        .chars()
        .filter(|c| c.is_numeric())
        .collect()
}

pub fn modify_numbers(result: &str) -> String {
    let first_num: &str = &result[0..1];
    let r = result.len();
    let l = r - 1;
    let last_num: &str = &result[l..r];

    let number = format!("{first_num}{last_num}");

    number
}

pub fn sum_numbers(v2: Vec<u32>) -> u32 {
    v2
        .iter()
        .sum()
}

//pub fn modify_numbers(number: u32) -> u32 {
//        if number < 10 {
//            11 * number
//        } else {
//            number
//        }
//}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn filter_letters() {
        let item = "sdfadhk22hkdjl";

        assert_eq!("22", remove_letters(item))
    }

    #[test]
    fn one_digit() {
        let result = "2";

        assert_eq!("22", modify_numbers(result))
    }

    #[test]
    fn two_digits() {
        let result = "22";

        assert_eq!("22", modify_numbers(result))
    }

    #[test]
    fn three_digits() {
        let result = "232";

        assert_eq!("22", modify_numbers(result))
    }

    #[test]
    fn sums() {
        let v2 = vec![2, 3, 4];

        assert_eq!(9, sum_numbers(v2))
    }
}
