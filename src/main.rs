//pub mod day_one;
//pub mod day_two;
//pub mod day03;
pub mod day04;

use std::error::Error;

fn main() -> Result<(), Box<dyn Error>> {
    day04::input::solve()
}
