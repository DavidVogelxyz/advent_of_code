use super::input;

pub fn solve(input: &str) {
    let matches = input
        .lines()
        .map(input::read_card)
        .map(|(winning_numbers, my_numbers)| {
            calculate_match_count(&winning_numbers, &my_numbers)
        })
        .collect::<Vec<u32>>();

    let answer = calculate_num_scratchcards(&matches);

    println!("Sum of scratcher Tickets: {}", answer);
}

fn calculate_match_count(winning_numbers: &[u32], my_numbers: &Vec<u32>) -> u32 {
    let mut matches: u32 = 0;

    for my_number in my_numbers {
        if winning_numbers.contains(my_number) {
            matches += 1;
        }
    }

    matches
}

fn calculate_num_scratchcards(matches: &Vec<u32>) -> u32 {
    let mut copies: Vec<u32> = vec![0; matches.len()];
    let mut scratchcards: u32 = 0;

    // enumerate over matches
    for (i, match_count) in matches.iter().enumerate() {
        // get the cards copies
        let card_copies = *copies.get(i).unwrap_or(&0);
        scratchcards += 1 + card_copies;

        // if the card has matches, add 1 to every n_match cards
        // if index j + 1 doesn't exist, it will be ignored
        if *match_count > 0 {
            for j in 0..*match_count {
                let next_card = i + 1 + j as usize;
                if next_card < matches.len() {
                    let next_card_copies = copies.get_mut(next_card).unwrap();
                    *next_card_copies += card_copies + 1; // add 1 for the original card
                }
            }
        }
    }

    scratchcards
}
