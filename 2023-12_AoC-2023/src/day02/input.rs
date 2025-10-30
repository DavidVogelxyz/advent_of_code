use std::error::Error;
use std::fs;

// no more than 12 red
// no more than 13 green
// no more than 14 blue

#[derive(Debug, PartialEq)]
pub struct Set {
    red: u32,
    green: u32,
    blue: u32,
}

impl Set {
    pub fn is_possible(&self, red_max: u32, green_max: u32, blue_max: u32) -> bool {
        self.red <= red_max && self.green <= green_max && self.blue <= blue_max
    }
}

#[derive(Debug, PartialEq)]
pub struct Game {
    pub id: u32,
    sets: Vec<Set>,
}

impl Game {
    pub fn is_possible(&self, red_max: u32, green_max: u32, blue_max: u32) -> bool {
        self.sets
            .iter()
            .all(|set| set.is_possible(red_max, green_max, blue_max))
    }

    pub fn step_two(&self) -> u32 {
        let mut red_max: u32 = 0;
        let mut green_max: u32 = 0;
        let mut blue_max: u32 = 0;

        for set in &self.sets {
            if set.red > red_max {
                red_max = set.red;
            }

            if set.green > green_max {
                green_max = set.green;
            }

            if set.blue > blue_max {
                blue_max = set.blue;
            }
        }

        red_max * green_max * blue_max
    }
}

pub fn get_game_id(input: &str) -> u32 {
    let mut game_id_str = String::new();

    for c in input.chars() {
        if c.is_numeric() {
            game_id_str.push(c);
        } else if c == ':' {
            break;
        }
    }

    game_id_str.parse::<u32>().unwrap()
}

pub fn parse_set_info(input: &str) -> Set {
    let mut red: u32 = 0;
    let mut green: u32 = 0;
    let mut blue: u32 = 0;

    let set = input.split(',');

    for item in set {
        let split: Vec<&str> = item.trim().split(' ').collect();
        let number = split[0].parse::<u32>().unwrap();
        let color = split[1];

        match color {
            "red" => red = number,
            "green" => green = number,
            "blue" => blue = number,
            _ => panic!("invalid color: {}", color),
        }
    }

    Set {
        red,
        green,
        blue,
    }
}

pub fn parse_game(input: &str) -> Game {
    let game_id = get_game_id(input);

    let mut input = input.split(':');
    let sets = input.nth(1).unwrap().split(';');
    let sets: Vec<Set> = sets.map(|set| parse_set_info(set)).collect();

    Game {
        id: game_id,
        sets,
    }
}

pub fn parse_games(input: &str) -> Vec<Game> {
    input.lines().map(|line| parse_game(line)).collect()
}

pub fn solve() -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string("src/day02/input.txt")?;

    let games = parse_games(&contents);

    // step 1
    //const RED_MAX: u32 = 12;
    //const GREEN_MAX: u32 = 13;
    //const BLUE_MAX: u32 = 14;

    //let possible_sum: u32 = games
    //    .iter()
    //    .filter(|g| g.is_possible(RED_MAX, GREEN_MAX, BLUE_MAX))
    //    .map(|g| g.id)
    //    .sum();

    //println!("sum: {}", possible_sum);

    // step 2
    let power: u32 = games
        .iter()
        .map(|g| g.step_two())
        .sum::<u32>();

    println!("power: {}", power);

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_game_id() {
        let contents: String = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green".to_string();
        assert_eq!(1, get_game_id(&contents));

        let contents: String = "Game 4: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green".to_string();
        assert_eq!(4, get_game_id(&contents));
    }

    #[test]
    fn test_parse_set_info() {
        let contents: String = "2 blue, 4 red".to_string();
        let answer = Set {
            red: 4,
            blue: 2,
            green: 0,
        };
        assert_eq!(answer, parse_set_info(&contents));

        let contents: String = "9 blue, 6 red, 0 green".to_string();
        let answer = Set {
            red: 6,
            blue: 9,
            green: 0,
        };
        assert_eq!(answer, parse_set_info(&contents));
    }

    #[test]
    fn test_parse_game() {
        let contents: String = "Game 1: 2 blue, 4 red; 6 blue, 9 green".to_string();
        let answer = Game {
            id: 1,
            sets: vec!(
                Set {
                    red: 4,
                    blue: 2,
                    green: 0,
                },
                Set {
                    red: 0,
                    blue: 6,
                    green: 9,
                }),
        };
        assert_eq!(answer, parse_game(&contents));
    }
}
