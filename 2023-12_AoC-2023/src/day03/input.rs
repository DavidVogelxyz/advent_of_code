use std::error::Error;
use std::fs;
use std::collections::{HashMap, HashSet};

pub fn read_to_map(input: &str) -> Map {
    let mut map: Vec<Vec<char>> = Vec::new();
    let mut width: usize = 0;
    let mut height: usize = 0;

    for line in input.lines() {
        let mut row: Vec<char> = Vec::new();

        for c in line.chars() {
            row.push(c);
        }

        width = row.len();
        map.push(row);
        height += 1;
    }

    Map {
        map,
        width,
        height,
    }
}

pub struct Map {
    pub map: Vec<Vec<char>>,
    pub height: usize,
    pub width: usize,
}

#[derive(Debug, PartialEq)]
pub enum SymbolType {
    Number(u32),
    Empty,
    Symbol(char),
}

#[derive(Debug, PartialEq)]
pub struct Symbol {
    pub symbol_type: SymbolType,
    pub id: usize,
}

pub fn get_symbol_map(map: &Map) -> HashMap<(usize, usize), Symbol> {
    let mut symbols: HashMap<(usize, usize), Symbol> = HashMap::new();
    let mut id = 0;

    for y in 0..map.height {
        let mut visited: HashSet<u32> = HashSet::new();

        for x in 0..map.width {
            if visited.contains(&(x as u32)) {
                continue;
            }

            let c = map.map[y][x];

            if c.is_ascii() {
                let num: u32 = c.to_digit(10).unwrap();
                let mut x2 = x + 1;
                let mut digits: Vec<u32> = vec![num];

                while x2 < map.width {
                    let c2 = map.map[y][x2];

                    if c2.is_ascii_digit() {
                        visited.insert(x2 as u32);
                        let num = c2.to_digit(10).unwrap();
                        digits.push(num);
                        x2 += 1;
                    } else {
                        break;
                    }
                }

                // converts the digits vector into a single integer
                let num = digits.iter().fold(0, |acc, x| acc * 10 + x);

                for (i, _num) in digits.iter().enumerate() {
                    symbols.insert(
                        (x + i, y),
                        Symbol {
                            symbol_type: SymbolType::Number(num),
                            id
                        },
                    );
                }

                symbols.insert(
                    (x, y),
                    Symbol {
                        symbol_type: SymbolType::Number(num),
                        id,
                    },
                );
            } else if c == '.' {
                symbols.insert(
                    (x, y),
                    Symbol {
                        symbol_type: SymbolType::Empty,
                        id,
                    },
                );
            } else {
                symbols.insert(
                    (x, y),
                    Symbol {
                        symbol_type: SymbolType::Symbol(c),
                        id,
                    },
                );
            }

            id += 1
        }
    }

    symbols
}

pub fn solve() -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string("src/day03/sample.txt")?;

    dbg!(contents);

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_read_to_map() {
        let input = "467.\n\
                     8...\n\
                     32.1\n\
                     ....";
        let map = read_to_map(input);
        assert_eq!(map.width, 4);
        assert_eq!(map.height, 4);
        assert_eq!(map.map[0][0], '4');
        assert_eq!(map.map[0][1], '6');
        assert_eq!(map.map[0][2], '7');
        assert_eq!(map.map[0][3], '.');
        assert_eq!(map.map[1][0], '8');
        assert_eq!(map.map[1][1], '.');
        assert_eq!(map.map[1][2], '.');
        assert_eq!(map.map[1][3], '.');
        assert_eq!(map.map[2][0], '3');
        assert_eq!(map.map[2][1], '2');
        assert_eq!(map.map[2][2], '.');
        assert_eq!(map.map[2][3], '1');
        assert_eq!(map.map[3][0], '.');
        assert_eq!(map.map[3][1], '.');
        assert_eq!(map.map[3][2], '.');
        assert_eq!(map.map[3][3], '.');
    }

    #[test]
    fn test_get_symbol_map() {
        let input = "467.\n\
                     ...*\n\
                     ..35\n";

        let map = read_to_map(input);
        let engine_symbols = get_symbol_map(&map);

        let mut expected: HashMap<(usize, usize), Symbol> = HashMap::new();

        expected.insert(
            (0, 0),
            Symbol {
                symbol_type: SymbolType::Number(467),
                id: 0,
            },
        );

        expected.insert(
            (1, 0),
            Symbol {
                symbol_type: SymbolType::Number(467),
                id: 0,
            },
        );

        expected.insert(
            (2, 0),
            Symbol {
                symbol_type: SymbolType::Number(467),
                id: 0,
            },
        );

        expected.insert(
            (3, 0),
            Symbol {
                symbol_type: SymbolType::Empty,
                id: 1,
            },
        );

        expected.insert(
            (0, 1),
            Symbol {
                symbol_type: SymbolType::Empty,
                id: 2,
            },
        );

        expected.insert(
            (1, 1),
            Symbol {
                symbol_type: SymbolType::Empty,
                id: 3,
            },
        );

        expected.insert(
            (2, 1),
            Symbol {
                symbol_type: SymbolType::Empty,
                id: 4,
            },
        );

        expected.insert(
            (3, 1),
            Symbol {
                symbol_type: SymbolType::Symbol('*'),
                id: 5,
            },
        );

        expected.insert(
            (0, 2),
            Symbol {
                symbol_type: SymbolType::Empty,
                id: 6,
            },
        );

        expected.insert(
            (1, 2),
            Symbol {
                symbol_type: SymbolType::Empty,
                id: 7,
            },
        );

        expected.insert(
            (2, 2),
            Symbol {
                symbol_type: SymbolType::Number(35),
                id: 8,
            },
        );

        expected.insert(
            (3, 2),
            Symbol {
                symbol_type: SymbolType::Number(35),
                id: 8,
            },
        );

        assert_eq!(engine_symbols, expected);
    }
}
