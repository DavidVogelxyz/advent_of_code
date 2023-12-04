pub mod day_one;

use std::error::Error;

fn main() -> Result<(), Box<dyn Error>> {
    day_one::solve()
}
