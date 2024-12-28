// rustc 17a.rs

fn readln() -> String {
    std::io::stdin().lines().next().unwrap().unwrap()
}

fn read_after_colon() -> String {
    let line = readln();
    let colon = line.find(":").unwrap() + 2;
    line[colon..].to_string()
}

fn read_register() -> usize {
    read_after_colon().parse::<usize>().unwrap()
}

fn solve(mut reg: Vec<usize>, program: Vec<usize>) -> String {
    let mut ans = String::new();
    let mut cur: usize = 0;
    while cur < program.len() {
        match program[cur] {
            0 => {
                reg[4] = reg[4] >> reg[program[cur + 1]];
                cur += 2
            },
            1 => {
                reg[5] = reg[5] ^ program[cur + 1];
                cur += 2
            },
            2 => {
                reg[5] = reg[program[cur + 1]] % 8;
                cur += 2
            },
            3 => {
                if reg[4] != 0 {
                    cur = program[cur + 1]
                } else {
                    cur += 2
                }
            },
            4 => {
                reg[5] = reg[5] ^ reg[6];
                cur += 2
            },
            5 => {
                if !ans.is_empty() {
                    ans.push_str(",")
                }
                ans.push_str(&(reg[program[cur + 1]] % 8).to_string());
                cur += 2
            },
            6 => {
                reg[5] = reg[4] >> reg[program[cur + 1]];
                cur += 2
            },
            7 => {
                reg[6] = reg[4] >> reg[program[cur + 1]];
                cur += 2
            },
            _ => {
                unreachable!();
            }
        }
    }
    ans
}

fn main() {
    let reg = vec![0, 1, 2, 3, read_register(), read_register(), read_register()];
    readln();
    let program_string = read_after_colon();
    let program: Vec<_> = program_string.split(",").map(|x| x.parse::<usize>().unwrap()).collect();
    let ans = solve(reg, program);
    println!("{}", ans);
}
