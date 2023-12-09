pub mod day01;
pub mod day02;
//pub mod day03;
pub mod day04;
pub mod day04_redo;

use std::error::Error;
//use std::fs;

fn main() -> Result<(), Box<dyn Error>> {
    day04::input::solve()

    //let input = fs::read_to_string("src/day04/input.txt")?;

    //day04_redo::part2::solve(&input);

    //Ok(())
}
