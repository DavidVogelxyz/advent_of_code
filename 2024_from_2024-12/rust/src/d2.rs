use std::fs;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file.")
}

pub fn parse(input: String) -> i32 {
    let mut total = 0;

    for line in input.lines() {
        //let arr: Vec<&str> = line.trim().split_whitespace().collect::<Vec<_>>();
        let line = line.trim().split_whitespace().collect::<Vec<_>>();
        let line_iter = line.iter();
        let mut v: Vec<i32> = Vec::new();

        for item in line_iter {
            let value = item.parse::<i32>().unwrap();
            v.push(value);
        }

        let mut v_iter = v.iter();
        let mut prev = v_iter.next().expect("num");
        let mut curr_num = v_iter.next().expect("num");

        let is_increasing;
        let mut is_safe = true;
        let mut diff;

        if curr_num < prev {
            is_increasing = false;
        } else if curr_num > prev {
            is_increasing = true;
        } else {
            continue;
        }

        if is_increasing == false {
            diff = prev - curr_num;
        } else {
            diff = curr_num - prev;
        }

        if diff < 1 || diff > 3 {
            continue;
        }

        for item in v_iter.clone() {
            prev = curr_num;
            curr_num = item;

            if is_increasing == false {
                diff = prev - curr_num;
            } else {
                diff = curr_num - prev;
            }

            if diff < 1 || diff > 3 {
                is_safe = false;
                break;
            }
        }

        if is_safe == true {
            total += 1
        }
    }

     total
}

pub fn day_two_part_one(file: &str) -> i32 {
    let contents = read_file(file);

    parse(contents)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_two_part_one_test() {
        let file = "../inputs/d2_test.txt";

        assert_eq!(2, day_two_part_one(file))
    }
}
