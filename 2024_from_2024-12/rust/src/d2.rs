use std::fs;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file.")
}

pub fn parse_part_one(input: String) -> i32 {
    let mut total = 0;

    for line in input.lines() {
        let line = line.trim().split_whitespace().collect::<Vec<_>>();
        let line_iter = line.iter();
        let mut v: Vec<i32> = Vec::new();

        for item in line_iter {
            let value = item.parse::<i32>().unwrap();
            v.push(value);
        }

        let exit_code = proc_anal(v);

        if exit_code == 0 {
            total += 1;
        }
    }

    total
}

pub fn proc_anal(v: Vec<i32>) -> i32 {
    let mut prev = v[0];
    let mut curr_num = v[1];

    let is_increasing;

    if curr_num < prev {
        is_increasing = false;
    } else if curr_num > prev {
        is_increasing = true;
    } else {
        return 1
    }

    for i in 1.. v.len() {
        prev = v[i - 1];
        curr_num = v[i];

        let diff = prev - curr_num;
        let diff_abs = diff.abs();

        if diff_abs < 1 || diff_abs > 3 {
            return 1
        }

        if is_increasing == true && prev > curr_num {
            return 1
        } if is_increasing == false && curr_num > prev {
            return 1
        }
    }

    return 0
}

pub fn parse_part_two(input: String) -> i32 {
    let mut total = 0;

    for line in input.lines() {
        let line = line.trim().split_whitespace().collect::<Vec<_>>();
        let line_iter = line.iter();
        let mut v: Vec<i32> = Vec::new();

        for item in line_iter {
            let value = item.parse::<i32>().unwrap();
            v.push(value);
        }

        let exit_code = proc_anal(v.clone());

        if exit_code == 0 {
            total += 1;
        } else {
            for j in 0.. v.len() {
                let mut v_internal = v.clone();
                v_internal.remove(j);

                let exit_code_internal = proc_anal(v_internal);

                if exit_code_internal == 0 {
                    total += 1;
                    break;
                }
            }
        }
    }

    total
}

pub fn day_two_part_one(file: &str) -> i32 {
    let contents = read_file(file);

    parse_part_one(contents)
}

pub fn day_two_part_two(file: &str) -> i32 {
    let contents = read_file(file);

    parse_part_two(contents)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_two_part_one_test() {
        let file = "../inputs/d2_test.txt";

        assert_eq!(2, day_two_part_one(file))
    }

    #[test]
    fn day_two_part_two_test() {
        let file = "../inputs/d2_test.txt";

        assert_eq!(4, day_two_part_two(file))
    }
}
