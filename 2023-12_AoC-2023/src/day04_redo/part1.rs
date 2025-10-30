use super::input;

pub fn solve(input: &str) {
    let answer: u32 = input
        .lines()
        .map(input::read_card)
        .map(|(winning_numbers, my_numbers)| {
            calculate_winning_numbers(&winning_numbers, &my_numbers)
        })
        .sum();

    println!("Sum of scratcher Tickets: {}", answer);
}

fn calculate_winning_numbers(winning_numbers: &[u32], my_numbers: &Vec<u32>) -> u32 {
    let mut points: u32 = 0;

    for my_number in my_numbers {
        if winning_numbers.contains(my_number) {
            points += 1;
        }
    }

    const BASE: u32 = 2;

    match points {
        0 => 0,
        1 => 1,
        //_ => BASE.pow(points) / 2,
        _ => BASE.pow(points - 1),
    }
}
