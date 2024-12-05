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

        let mut prev = v[0];
        let mut curr_num = v[1];

        let is_increasing;
        let mut is_safe = true;

        if curr_num < prev {
            is_increasing = false;
        } else if curr_num > prev {
            is_increasing = true;
        } else {
            continue
        }

        for i in 1.. v.len() {
            prev = v[i - 1];
            curr_num = v[i];

            let diff = prev - curr_num;
            let diff_abs = diff.abs();

            if diff_abs < 1 || diff_abs > 3 {
                is_safe = false;
                continue
            }

            if is_increasing == true && prev > curr_num {
                is_safe = false;
                continue
            } if is_increasing == false && curr_num > prev {
                is_safe = false;
                continue
            }
        }

        if is_safe == true {
            total += 1;
        }
    }

    total
}

pub fn parse_part_two(input: String) -> i32 {
    let mut total = 0;

    for line in input.lines() {
        // DEBUG
        //println!("attempting line: {}", line);

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

        let mut polarity;
        let mut is_safe = true;
        let mut diff;

        if curr_num < prev {
            polarity = -1;
        } else if curr_num > prev {
            polarity = 1;
        } else {
            polarity = 0;
        }

        if polarity == -1 {
            diff = prev - curr_num;
        } else if polarity == 1 {
            diff = curr_num - prev;
        } else {
            diff = 0;
        }

        if diff < 1 || diff > 3 {
            is_safe = false;
        }

        for item in v_iter.clone() {
            prev = curr_num;
            curr_num = item;

            if polarity == -1 {
                diff = prev - curr_num;
            } else if polarity == 1 {
                diff = curr_num - prev;
            } else {
                if curr_num < prev {
                    polarity = -1;
                    diff = prev - curr_num;
                } else if curr_num > prev {
                    polarity = 1;
                    diff = curr_num - prev;
                } else {
                    polarity = 0;
                    diff = 0;
                }
            }

            if diff < 1 || diff > 3 {
                is_safe = false;
                break;
            }
        }

        // DEBUG
        //if is_safe == true {
        //    println!("THIS ONE SUCCEEDED WITHOUT MANIPULATION: {:?}", v);
        //}

        if is_safe == false {
            let mut n = 0;

            while n < v.len() {
                let mut v_clone = v.clone();
                v_clone.remove(n);
                let mut v_clone_iter = v_clone.iter();
                let mut prev = v_clone_iter.next().expect("num");
                let mut curr_num = v_clone_iter.next().expect("num");
                n += 1;

                let polarity;
                is_safe = true;
                let mut diff;

                if curr_num < prev {
                    polarity = -1;
                } else if curr_num > prev {
                    polarity = 1;
                } else {
                    polarity = 0;
                }

                if polarity == -1 {
                    diff = prev - curr_num;
                } else if polarity == 1 {
                    diff = curr_num - prev;
                } else {
                    diff = 0;
                }

                if diff < 1 || diff > 3 {
                    is_safe = false;
                    continue;
                }

                for item in v_clone_iter.clone() {
                    prev = curr_num;
                    curr_num = item;

                    if polarity == -1 {
                        diff = prev - curr_num;
                    } else if polarity == 1 {
                        diff = curr_num - prev;
                    } else {
                        is_safe = false;
                        continue;
                    }

                    if diff < 1 || diff > 3 {
                        is_safe = false;
                        continue;
                    }

                }

                if is_safe == true {
                    // DEBUG
                    //println!("THIS ONE WAS PROBLEM DAMPENED: {:?}", v_clone);
                    break;
                }
            }

            // DEBUG
            //if is_safe == false {
            //    println!("THIS ONE COMPLETELY FAILED: {:?}", v);
            //}
        }

        if is_safe == true {
            total += 1
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
