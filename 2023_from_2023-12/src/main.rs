pub mod day_two;

use std::error::Error;

fn main() -> Result<(), Box<dyn Error>> {
    day_two::solve()
}
