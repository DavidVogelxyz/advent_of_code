use std::fs;
use std::collections::HashMap;

pub fn read_file(file: &str) -> String {
    fs::read_to_string(file)
        .expect("Should be able to read file")
}

pub fn are_there_evens(input: String) {
    let mut line_number = 1;

    for line in input.lines() {
        let v = line.trim().split(",").collect::<Vec<_>>();

        let length = v.len();

        if length % 2 == 0 {
            println!("Line {} is even!", line_number);
        }

        line_number += 1;
    }
}

pub fn split_file(input: String) -> (String, String) {
    // first attempt
    // returns "usize" (the byte index)
    //let v = input.find("\n\n").expect("blank line");
    //println!("should have the blank line at byte {}", v);

    // second attempt, part one
    //println!("{}", input);
    let mut input = input;
    let split_byte = input.find("\n\n").expect("blank line");

    // second attempt, part two
    //let input_instructions = input.split_off(split_byte + 2);

    // second attempt, part three
    //let input_instructions = input.split_off(split_byte);
    //input_instructions = input_instructions.trim().to_string();

    let input_instructions = input.split_off(split_byte).trim().to_string();
    let input_rules = input.trim().to_string();

    // DEBUG
    //println!("{}", input_instructions);
    //println!("{}", input_rules);

    (input_rules, input_instructions)
}

pub fn parse_rules(input: String) -> HashMap<u32, Vec<u32>> {
    let mut rules: HashMap<u32, Vec<u32>> = HashMap::new();
    //let rules: Vec<u32, Vec<u32>> = Vec::new();
    for line in input.lines() {
        let mut key_values = Vec::new();
        let output = line.trim().split('|').collect::<Vec<_>>();

        let output_key = output[1].parse::<u32>().unwrap();
        let output_value = output[0].parse::<u32>().unwrap();

        // DEBUG
        //println!("this should be a key: {}", output[1]);
        //println!("this should be a value: {}", output[0]);

        if rules.contains_key(&output_key) == false {
            key_values.push(output_value);
            rules.insert(output_key, key_values);
        } else {
            key_values = rules.get(&output_key).expect("should be vec of u32").to_owned();
            key_values.push(output_value);
            rules.insert(output_key, key_values);
        }
    }

    // DEBUG
    //println!("{:?}", rules);

    rules
}

pub fn walk_instructions_part_one(input: String, rules: HashMap<u32, Vec<u32>>) -> u32 {
    let mut sum = 0;

    for line in input.lines() {
        let mut line = line.trim().split(',').collect::<Vec<_>>();
        //println!("new line: {:?}", line);
        line.reverse();
        //println!("this is the line in reverse: {:?}", line);
        let mut to_be_checked = Vec::new();
        let mut seen = Vec::new();
        let mut fail = false;

        for element in line {
            to_be_checked.push(element.parse::<u32>().unwrap());
        }

        //println!("checking line {:?}", to_be_checked);

        for element in to_be_checked.clone() {
            if ! seen.contains(&element) {
                //println!("saw {} for the first time", element);
                seen.push(element);
            }

            if ! rules.contains_key(&element) {
                //println!("{} has no known dependents", element);
                continue
            } else {
                for dependent in rules.get(&element).expect("value") {
                    //println!("{} depends on {}", element, dependent);

                    if seen.contains(dependent) {
                        fail = true;
                        //println!("failed because {} depends on {}, but {} has already been seen!", element, dependent, dependent);
                        break;
                    }
                }
            }

            if fail == true {
                break;
            }
        }

        if fail == true {
            continue;
        }

        let mid = to_be_checked.len() / 2;

        sum += to_be_checked[mid];
    }

    sum
}

pub fn walk_instructions_part_two(input: String, rules: HashMap<u32, Vec<u32>>) -> u32 {
    let mut sum = 0;
    let mut line_number = 0;
    // these variables are an admission that this code is BAD
    let mut iteration_largest: u64 = 0;
    let mut line_most_iterations: u64 = 0;
    let mut iteration_total: u64 = 0;

    for line in input.lines() {
        line_number += 1;
        let mut line = line.trim().split(',').collect::<Vec<_>>();
        //println!("new line: {:?}", line);
        line.reverse();
        //println!("this is the line in reverse: {:?}", line);
        let mut to_be_checked = Vec::new();
        let mut fail_current_loop: bool;
        let mut required_reordering = false;
        let mut loop_count: u64 = 0;

        for element in line {
            to_be_checked.push(element.parse::<u32>().unwrap());
        }

        //println!("checking line {:?}", to_be_checked);

        loop {
            let mut seen = Vec::new();
            let mut count = 0;
            fail_current_loop = false;

            for element in to_be_checked.clone() {
                if ! seen.contains(&element) {
                    //println!("saw {} for the first time", element);
                    seen.push(element);
                }

                if ! rules.contains_key(&element) {
                    //println!("{} has no known dependents", element);
                    continue
                } else {
                    for dependent in rules.get(&element).expect("value") {
                        //println!("{} depends on {}", element, dependent);

                        if seen.contains(dependent) {
                            fail_current_loop = true;
                            required_reordering = true;
                            //println!("fail_current_looped because {} depends on {}, but {} has already been seen!", element, dependent, dependent);
                            //println!("let's remove {}, and that is {}", count, element);
                            to_be_checked.remove(count);
                            to_be_checked.insert(0, element.to_owned());
                            // to speed this up, the solution may be to swap
                            // but, unsure of how to pass the index of the other item
                            //to_be_checked.swap(idx_element, idx_dependent);
                            break;
                        }
                    }
                }

                //println!("{:?}", to_be_checked);

                count += 1;

                if fail_current_loop == true {
                    break;
                }
            }

            if fail_current_loop == false {
                break;
            }

            loop_count += 1;

            // this code shouldn't be looping as much as it does
            //println!("looped on line {} -- try # {}", line_number, loop_count);
        }

        if required_reordering == false {
            continue;
        }

        let mid = to_be_checked.len() / 2;

        sum += to_be_checked[mid];

        // this code is dumb
        iteration_total += loop_count;
        println!("line {} required {} iterations to solve", line_number, loop_count);

        // more admissions of disaster
        if loop_count > iteration_largest {
            iteration_largest = loop_count;
            line_most_iterations = line_number;
        }
    }

    // this is just embarassing
    // the line with the most loops was line 139, and it took 2,366,582 iterations to solve
    println!("the line with the most loops was line {}, and it took {} iterations to solve", line_most_iterations, iteration_largest);
    // the total number of iterations was 8,744,366
    println!("the total number of iterations was {}", iteration_total);


    sum
}

pub fn day_five_curious(file: &str) {
     let input = read_file(file);

     are_there_evens(input);
 }

pub fn day_five_part_one(file: &str) -> u32 {
     let input = read_file(file);

     let files = split_file(input);

     let input_rules = files.0;
     let input_instructions = files.1;

     let rules = parse_rules(input_rules);

     walk_instructions_part_one(input_instructions, rules)
 }

pub fn day_five_part_two(file: &str) -> u32 {
     let input = read_file(file);

     let files = split_file(input);

     let input_rules = files.0;
     let input_instructions = files.1;

     let rules = parse_rules(input_rules);

     walk_instructions_part_two(input_instructions, rules)
 }

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_five_part_one_test() {
        let file = "../inputs/d5_test.txt";

        assert_eq!(143, day_five_part_one(file));
    }

    #[test]
    fn day_five_part_two_test() {
        let file = "../inputs/d5_test.txt";

        assert_eq!(123, day_five_part_two(file));
    }
}
