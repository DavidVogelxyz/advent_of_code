use std::fs;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file")
}

pub fn turn(char: char) -> char {
    let mut char = char;

    if char == '^' {
        char = '>'
    } else if char == '>' {
        char = 'v'
    } else if char == 'v' {
        char = '<'
    } else if char == '<' {
        char = '^'
    }

    char
}

pub fn attempt_to_walk(grid: Vec<Vec<char>>, guard: (usize, usize, char)) -> (Vec<Vec<char>>, usize, usize, char) {
    let mut grid = grid;
    let r = guard.0;
    let c = guard.1;
    let mut char = grid[r][c];
    let mut next_tile = '?';
    let mut r_next = 0;
    let mut c_next = 0;
    let mut offmap = false;

    if char == '^' {
        if r > 0 {
            next_tile = grid[r - 1][c];
            r_next = r - 1;
            c_next = c;
        } else {
            offmap = true;
        }
    } else if char == '>' {
        if c + 1 < grid[r].len() {
            next_tile = grid[r][c + 1];
            r_next = r;
            c_next = c + 1;
        } else {
            offmap = true;
        }
    } else if char == 'v' {
        //println!("char is on row {}, wants to move to {}, and grid.len is {}", r, r + 1, grid.len());
        if r + 1 < grid.len() {
            next_tile = grid[r + 1][c];
            r_next = r + 1;
            c_next = c;
        } else {
            offmap = true;
        }
    } else if char == '<' {
        if c > 0 {
            next_tile = grid[r][c - 1];
            r_next = r;
            c_next = c - 1;
        } else {
            offmap = true;
        }
    }

    if offmap == true {
        grid[r][c] = 'X';
        return (grid, r, c, char)
    }

    if next_tile != '#' {
        grid[r][c] = 'X';
        grid[r_next][c_next] = char;
        //println!("guard moved to: ({}, {})", r_next, c_next);
        (grid, r_next, c_next, char)
    } else {
        char = turn(char);
        grid[r][c] = char;
        //println!("guard turned at: ({}, {})", r, c);
        (grid, r, c, char)
    }
}

pub fn find_guard(grid: Vec<Vec<char>>) -> (usize, usize, char) {
    let mut guard_found = false;
    let mut r = 0;
    let mut c = 0;
    let mut value = '.';

    for row in 0.. grid.len() {
        for col in 0.. grid[row].len() {
            value = grid[row][col];

            if value == '^' || value == '>' || value == 'v' || value == '<' {
                guard_found = true;
                r = row;
                c = col;
                break;
            }
        }

        if guard_found == true {
            break;
        }
    }

    //println!("guard is at coords ({}, {})", r, c);
    (r, c, value)
}

pub fn walk(input: String) -> u32 {
    let mut grid = input
        .trim()
        .lines()
        .map(|line| line
            .trim()
            .chars()
            .collect::<Vec<_>>())
        .collect::<Vec<_>>();

    let mut guard_output = find_guard(grid.clone());
    let mut output;
    let mut grid_new;
    let mut guard_output_new;

    loop {
        output = attempt_to_walk(grid, guard_output);
        grid_new = output.0;
        guard_output_new = (output.1, output.2, output.3);

        if guard_output_new == guard_output {
            break;
        }

        grid = grid_new;
        guard_output = guard_output_new;
    }

    sum(grid_new)
}

pub fn sum(grid: Vec<Vec<char>>) -> u32 {
    let mut sum = 0;

    for row in 0.. grid.len() {
        for col in 0.. grid[row].len() {
            let value = grid[row][col];

            if value == 'X' {
                sum += 1;
            }
        }
    }

    sum
}

pub fn day_six_part_one(file: &str) -> u32 {
    let input = read_file(file);

    walk(input)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_six_part_one_test() {
        let file = "../inputs/d6_test.txt";

        assert_eq!(41, day_six_part_one(file));
    }
}
