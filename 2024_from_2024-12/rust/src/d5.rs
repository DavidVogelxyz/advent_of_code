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

pub fn walk_instructions(input: String, rules: HashMap<u32, Vec<u32>>) -> u32 {
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

     walk_instructions(input_instructions, rules)
 }

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_five_part_one_test() {
        let file = "../inputs/d5_test.txt";

        assert_eq!(143, day_five_part_one(file));
    }
}
