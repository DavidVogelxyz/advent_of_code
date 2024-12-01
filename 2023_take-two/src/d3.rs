use std::fs;

pub fn read_file() -> String {
    let file_path = "inputs/d3p1_test.txt";

    fs::read_to_string(file_path)
        .expect("Should be able to read file.")
}

const DIRS: [[i8; 2]; 8] = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];

// returns Chars(['4', '6', '7', '.', '.', '1', '1', '4', '.', '.'])
// returns Vec named Chars
pub fn walk0(contents: String) {
    //let mut curr_num = 0;
    //let mut flag_add = false;
    //let mut flag_num_end = false;

    for line in contents.lines() {
        let char = line.chars();
        println!("{:?}", char);
    }
}

// same as walk0, but with no comments
pub fn walk1(contents: String) {
    for line in contents.lines() {
        let char = line.chars();
        println!("{:?}", char);
    }
}

// returns [52, 54, 55, 46, 46, 49, 49, 52, 46, 46]
// aka bytes
pub fn walk2(contents: String) {
    for line in contents.lines() {
        let char = line.as_bytes();
        println!("{:?}", char);
    }
}

// returns ['4', '6', '7', '.', '.', '1', '1', '4', '.', '.']
// returns Vec of chars
pub fn walk3(contents: String) {
    for line in contents.lines() {
        let char: Vec<char> = line.chars().collect();
        println!("{:?}", char);
    }
}

pub fn walk4(contents: String) -> Vec<u32> {
    let mut nums_to_sum: Vec<u32> = Vec::new();
    let mut curr_num: Vec<u32> = Vec::new();
    let mut flag_add = false;
    //let mut flag_num_end = false;

    for line in contents.lines() {
        let char: Vec<char> = line.chars().collect();

        for item in char {
            //if item.is_numeric() {
                //let item = item as i32;   // this turned it into bytes
                //let item = item.to_digit(10).expect("this should be a number.");
                //curr_num.push(item);
            //};
            if item.is_digit(10) {
                //let item = item as i32;   // this turned it into bytes
                let item = item.to_digit(10).expect("this should be a number.");
                curr_num.push(item);
                flag_add = true;
            } else {
                if flag_add == true {
                    //let mut new_num: u32 = 0;
                    let new_num: u32 = cat(&curr_num);
                    nums_to_sum.push(new_num);
                    println!("{:?}", new_num);
                    flag_add = false;
                    curr_num.clear();
                }
            };
        }
    }

    println!{"{:?}", nums_to_sum};
    return nums_to_sum
}

pub fn cat(vec: &Vec<u32>) -> u32 {
    vec
        .iter()
        .fold(0, |acc, elem| acc * 10 + elem)
}

pub fn sum_num(vec: Vec<u32>) -> u32 {
    vec
        .iter()
        .sum()
}

pub fn day_three_part_one() -> u32 {
    let contents = read_file();
    println!("{}", contents);
    println!("{:?}", DIRS);
    let nums_to_sum = walk4(contents);
    sum_num(nums_to_sum)
}
