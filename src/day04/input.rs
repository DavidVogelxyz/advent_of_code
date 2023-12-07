use std::error::Error;
use std::fs;

pub fn solve() -> Result<(), Box<dyn Error>> {
    let input = fs::read_to_string("src/day04/input.txt")?;

    let result = dbg!(parse_games(&input));

    //what needs to happen here is:
    //remove the card id and ':'
    //delineate the two lists by '|'
    //get two lists created for comparison
    //run the comparison
    //collect the power values
    //sum them

    let answer: u32 = result.iter().sum();

    dbg!(answer);

    Ok(())
}

pub fn replace_double_space(input: &str) -> String {
    input.replace("  ", " ")
}

pub fn get_card_id(input: &str) -> u32 {
    let mut card_id_str = String::new();

    for c in input.chars() {
        if c.is_numeric() {
            card_id_str.push(c)
        } else if c == ':' {
            break;
        }
    }

    card_id_str.parse::<u32>().unwrap()
}

pub fn parse_game(input: &str) -> String {
    input.split(':').nth(1).unwrap().to_string()
}

pub fn split_input(input: &str, v: usize) -> String {
    let input = input.split('|').nth(v).unwrap();
    input.trim().to_string()
}

pub fn get_list(input: &str) -> Vec<u32> {
    let mut list: Vec<u32> = Vec::new();

    let set = input.split(' ');

    for item in set {
        let split: Vec<&str> = item.trim().split(' ').collect();

        let number = split[0].parse::<u32>().unwrap();

        list.push(number);
    }

    list
}

pub fn compare_lists(win: Vec<u32>, mine: Vec<u32>) -> u32 {
    let mut count: u32 = 0;
    let base: u32 = 2;

    for item in mine {
        if win.contains(&item) {
            count += 1
        }
    }

    base.pow(count) / 2
}

pub fn per_line(input: &str) -> u32 {
    let input = parse_game(&replace_double_space(&input));

    let win = get_list(&split_input(&input, 0));
    let mine = get_list(&split_input(&input, 1));

    let result = compare_lists(win, mine);

    result
}

pub fn parse_games(input: &str) -> Vec<u32> {
    input.lines().map(|line| per_line(line)).collect()
}

//pub fn parse_card(input: &str) -> Vec<u32> {
//    let card_id = get_card_id(input);
//
//    let mut input = input.split(':');
//    let sets = input.nth(1).unwrap().split('|');
//
//    // this needs to be completed
//    let sets: Vec<Win> = sets.map(|set| get_list(set)).collect();
//
//    Win { sets }
//}

//pub fn points_to_list(input: u32) -> Vec<u32> {
//    let mut tally: Vec<u32> = Vec::new();
//
//    tally.push(input);
//
//    tally
//}

//pub fn sum_tally(input: Vec<u32>) -> u32 {
//    input.iter().sum()
//}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_replace_double_space() {
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
        let expected = "Card 1: 41 48 83 86 17 | 83 86 6 31 17 9 48 53";
        assert_eq!(expected, replace_double_space(input));

        let input = "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1";
        let expected = "Card 3: 1 21 53 59 44 | 69 82 63 72 16 21 14 1";
        assert_eq!(expected, replace_double_space(input));
    }

    #[test]
    fn test_get_card_id() {
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
        let expected = 1;
        assert_eq!(expected, get_card_id(input));

        let input = "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1";
        let expected = 3;
        assert_eq!(expected, get_card_id(input));
    }

    #[test]
    fn test_get_list() {
        let input = "41 48 83 86 17";
        let input = replace_double_space(input);
        let expected: Vec<u32> = vec![41, 48, 83, 86, 17];
        assert_eq!(expected, get_list(&input));

        let input = "1 21 53 59 44";
        let input = replace_double_space(input);
        let expected: Vec<u32> = vec![1, 21, 53, 59, 44];
        assert_eq!(expected, get_list(&input));
    }

    #[test]
    fn test_compare_lists() {
        let win: Vec<u32> = vec![41, 48, 83, 86, 17];
        let mine: Vec<u32> = vec![83, 86, 6, 31, 17, 9, 48, 53];
        let expected: u32 = 8;
        assert_eq!(expected, compare_lists(win, mine));

        let win: Vec<u32> = vec![1, 21, 53, 59, 44];
        let mine: Vec<u32> = vec![69, 82, 63, 72, 16, 21, 14, 1];
        let expected: u32 = 2;
        assert_eq!(expected, compare_lists(win, mine));
    }

    #[test]
    fn test_everything() {
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
        let input = replace_double_space(input);
        let input = parse_game(&input);

        let input1 = dbg!(input.split('|').nth(0).unwrap());
        let input1 = dbg!(input1.trim());

        let input2 = dbg!(input.split('|').nth(1).unwrap());
        let input2 = dbg!(input2.trim());

        let expected1: Vec<u32> = vec![41, 48, 83, 86, 17];
        let expected2: Vec<u32> = vec![83, 86, 6, 31, 17, 9, 48, 53];

        assert_eq!(expected1, get_list(input1));
        assert_eq!(expected2, get_list(input2));

        assert_eq!(8, compare_lists(get_list(input1), get_list(input2)));
    }

    #[test]
    fn test_everything2() {
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
        let input = parse_game(&replace_double_space(&input));

        let win = get_list(&split_input(&input, 0));
        let mine = get_list(&split_input(&input, 1));

        let result = compare_lists(win, mine);

        assert_eq!(8, result);
    }
}
