// rustc 17b.rs

fn readln() -> String {
    std::io::stdin().lines().next().unwrap().unwrap()
}

fn read_after_colon() -> String {
    let line = readln();
    let colon = line.find(":").unwrap() + 2;
    line[colon..].to_string()
}

fn main() {
    readln();
    readln();
    readln();
    readln();
    let program_string = read_after_colon();
    let program: Vec<usize> = program_string.split(",").map(|x| x.parse::<usize>().unwrap()).collect();
    let mut a: usize = 0;
    for v in program.iter().rev() {
        for x in 0..8 {
            let y = (a << 3) | x;
            if v ^ 5 == (y ^ (y >> ((y & 7) ^ 2))) & 7 {
                a = y;
                break
            }
        }
    }
    println!("{}", a);
}
