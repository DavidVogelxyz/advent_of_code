use std::fs;

pub fn read_file() -> String {
    let file_path = "inputs/d3_input.txt";

    fs::read_to_string(file_path)
        .expect("Should be able to read file.")
}

pub fn walk(input: &str) -> u32 {
    let grid = input
        .trim()
        .lines()
        .map(|line| line
            .trim()
            .chars()
            .collect::<Vec<_>>())
        .collect::<Vec<_>>();

    let mut sum = 0;
    let mut curr_num = 0;
    let mut has_adj_sym = false;

    for row in 0.. grid.len() {
        for col in 0.. grid[row].len() {
            let value = grid[row][col];

            if !value.is_ascii_digit() {
                continue
            }

            for row_offset in -1..=1 {
                for col_offset in -1..=1 {
                    if row_offset == 0 && col_offset == 0 {
                        continue
                    }

                    let adj_row = row as i32 + row_offset;
                    let adj_col = col as i32 + col_offset;

                    if adj_row < 0
                        || adj_row >= grid.len() as i32
                            || adj_col < 0
                            || adj_col >=grid[adj_row as usize].len() as i32
                    {
                        continue
                    }

                    let adj_value = grid[adj_row as usize][adj_col as usize];
                    if !adj_value.is_ascii_digit() && adj_value != '.' {
                        has_adj_sym = true;
                    }
                }
            }

            curr_num *= 10;
            curr_num += value.to_digit(10).unwrap();

            if col + 1 >= grid[row].len() || !grid[row][col + 1].is_ascii_digit() {
                if has_adj_sym {
                    sum += curr_num;
                }

                curr_num = 0;
                has_adj_sym = false;
            }
        }
    }

    sum
}

pub fn day_three_part_one() -> u32 {
    let contents = read_file();
    walk(&contents)
}
