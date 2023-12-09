pub fn read_card(input: &str) -> (Vec<u32>, Vec<u32>) {
    // split off the first part of the string before the ':'
    // then split that into a vector of strings, split by '|'
    // then split each of those strings into a vector of strings, split by ' '
    // then parse each of those strings into a vector of u32
    let numbers: Vec<&str> = input
        .split(':')
        .nth(1)
        .unwrap()
        .split('|')
        .collect::<Vec<&str>>();

    let winning_numbers = numbers[0]
        .trim()
        .replace("  ", " ")
        .split(' ')
        //.filter(|&x| !x.is_empty())
        .map(|x| x.trim().parse::<u32>().unwrap())
        .collect::<Vec<u32>>();

    let my_numbers = numbers[1]
        .trim()
        .replace("  ", " ")
        .split(' ')
        //.filter(|&x| !x.is_empty())
        .map(|x| x.trim().parse::<u32>().unwrap())
        .collect::<Vec<u32>>();

    (winning_numbers, my_numbers)
}

// this attempt to create a function for making the lists failed
//pub fn create_list(numbers: Vec<&str>, v: usize) {
//    numbers[v]
//        .trim()
//        .split(' ')
//        //the next line fails because "no method named '_is_empty_' found for ref `&str`"
//        .filter(|&x| !x._is_empty())
//        .map(|x| x.trim().parse::<u32>().unwrap())
//        .collect::<Vec<u32>>();
//}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_read_card() {
        let input = "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1";
        let (winning_numbers, my_numbers) = read_card(input);
        assert_eq!(winning_numbers, vec![1, 21, 53, 59, 44]);
        assert_eq!(my_numbers, vec![69, 82, 63, 72, 16, 21, 14, 1]);
    }
}
