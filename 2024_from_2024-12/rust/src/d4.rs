use std::fs;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file")
}

pub fn walk_part_one(input: String) -> i32 {
    let grid = input
        .trim()
        .lines()
        .map(|line| line
            .trim()
            .chars()
            .collect::<Vec<_>>())
        .collect::<Vec<_>>();

    let mut sum = 0;

    for row in 0.. grid.len() {
        for col in 0.. grid[row].len() {
            let value_x = grid[row][col];
            let mut c = 'X';

            if value_x != c {
                continue
            }

            //println!("starting 'X' found at ({}, {})", row, col);

            c = 'M';
            let results_m = adj_check_m_part_one(grid.clone(), row, col, c);
            for result in results_m {
                //println!("adjacent 'M' found at ({}, {})", result.0, result.1);
                c = 'A';
                let value_next = adj_check_next(grid.clone(), result.0, result.1, result.2, result.3, c);
                if (value_next.2, value_next.3) == (0, 0) {
                    //println!("couldn't find an adjacent 'A'");
                    continue
                }

                //println!("adjacent 'A' found at ({}, {})", value_next.0, value_next.1);

                c = 'S';
                let value_next = adj_check_next(grid.clone(), value_next.0, value_next.1, value_next.2, value_next.3, c);
                if (value_next.2, value_next.3) == (0, 0) {
                    //println!("couldn't find an adjacent 'S'");
                    continue
                }

                //println!("adjacent 'S' found at ({}, {})", value_next.0, value_next.1);
                sum += 1;
            }
        }
    }

    sum
}

pub fn adj_check_m_part_one(grid: Vec<Vec<char>>, row: usize, col: usize, c: char) -> Vec<(usize, usize, i32, i32)> {
    let mut results: Vec<(usize, usize, i32, i32)> = Vec::new();

    for row_offset in -1..=1 {
        for col_offset in -1..=1 {
            if row_offset == 0 && col_offset == 0{
                continue
            }

            let adj_row = row as i32 + row_offset;
            let adj_col = col as i32 + col_offset;

            if adj_row < 0
                || adj_row >= grid.len() as i32
                    || adj_col < 0
                    || adj_col >= grid[adj_row as usize].len() as i32
            {
                continue
            }

            let adj_value = grid[adj_row as usize][adj_col as usize];

            if adj_value == c {
                let row_off = row_offset;
                let col_off = col_offset;
                results.push((adj_row as usize, adj_col as usize, row_off, col_off));
            }
        }
    }

    //dbg!(results)
    results
}

pub fn adj_check_next(grid: Vec<Vec<char>>, row: usize, col: usize, row_off: i32, col_off: i32, c: char) -> (usize, usize, i32, i32) {
    let mut row_off: i32 = row_off;
    let mut col_off: i32 = col_off;
    let mut adj_row: i32 = 0;
    let mut adj_col: i32 = 0;
    let mut has_adj_sym = false;

    for row_offset in row_off..=row_off{
        for col_offset in col_off..=col_off {
            adj_row = row as i32 + row_offset;
            adj_col = col as i32 + col_offset;

            if adj_row < 0
                || adj_row >= grid.len() as i32
                    || adj_col < 0
                    || adj_col >= grid[adj_row as usize].len() as i32
            {
                continue
            }

            let adj_value = grid[adj_row as usize][adj_col as usize];
            if adj_value == c {
                has_adj_sym = true;
                row_off = row_offset;
                col_off = col_offset;
                break;
            }
        }
    }

    if has_adj_sym == true {
        return (adj_row as usize, adj_col as usize, row_off, col_off)
    } else {
        return (row, col, 0, 0);
    }
}

pub fn walk_part_two(input: String) -> i32 {
    let grid = input
        .trim()
        .lines()
        .map(|line| line
            .trim()
            .chars()
            .collect::<Vec<_>>())
        .collect::<Vec<_>>();

    let mut sum = 0;

    for row in 0.. grid.len() {
        for col in 0.. grid[row].len() {
            let mut check_x = 0;
            let value_x = grid[row][col];
            let mut c = 'A';

            if value_x != c {
                continue
            }

            //println!("starting 'A' found at ({}, {})", row, col);

            c = 'M';
            let results_m = adj_check_a_part_two(grid.clone(), row, col, c);
            for result in results_m {
                //println!("adjacent 'M' found at ({}, {})", result.0, result.1);
                c = 'S';
                let value_next = adj_check_next(grid.clone(), row, col, result.2 * -1, result.3 * -1, c);
                if (value_next.2, value_next.3) == (0, 0) {
                    //println!("couldn't find an adjacent 'S'");
                    continue
                }

                //println!("adjacent 'S' found at ({}, {})", value_next.0, value_next.1);
                check_x += 1;
            }

            if check_x == 2 {
                sum += 1;
            }
        }
    }

    sum
}

pub fn adj_check_a_part_two(grid: Vec<Vec<char>>, row: usize, col: usize, c: char) -> Vec<(usize, usize, i32, i32)> {
    let mut results: Vec<(usize, usize, i32, i32)> = Vec::new();

    for row_offset in -1..=1 {
        for col_offset in -1..=1 {
            if row_offset == 0 || col_offset == 0{
                continue
            }

            let adj_row = row as i32 + row_offset;
            let adj_col = col as i32 + col_offset;

            if adj_row < 0
                || adj_row >= grid.len() as i32
                    || adj_col < 0
                    || adj_col >= grid[adj_row as usize].len() as i32
            {
                continue
            }

            let adj_value = grid[adj_row as usize][adj_col as usize];

            if adj_value == c {
                let row_off = row_offset;
                let col_off = col_offset;
                results.push((adj_row as usize, adj_col as usize, row_off, col_off));
            }
        }
    }

    //dbg!(results)
    results
}

pub fn day_four_part_one(file: &str) -> i32 {
    let input = read_file(file);

    walk_part_one(input)
}

pub fn day_four_part_two(file: &str) -> i32 {
    let input = read_file(file);

    walk_part_two(input)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_four_part_one_test() {
        let file = "../inputs/d4_test.txt";

        assert_eq!(18, day_four_part_one(file));
    }

    #[test]
    fn day_four_part_two_test() {
        let file = "../inputs/d4_test.txt";

        assert_eq!(9, day_four_part_two(file));
    }
}
