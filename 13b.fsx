// dotnet fsi 13b.fsx

open System
open System.Text.RegularExpressions

let buttons =
    Regex(@"Button [AB]: X\+(\d+), Y\+(\d+)", RegexOptions.Compiled)
let prize =
    Regex(@"Prize: X=(\d+), Y=(\d+)", RegexOptions.Compiled)

let solve x y ax ay bx by =
    let mutable ans = 0L
    let d = ax * by - ay * bx
    let nad = x * by - bx * y
    let nbd = ax * y - x * ay
    if nad % d = 0L && nbd % d = 0L then
        (3L * nad + nbd) / d
    else
        0L

let rec main result =
    let line = Console.In.ReadLine()
    match line with
        | null -> result
        | some ->
            let a = buttons.Match(some)
            let ax = a.Groups[1].ToString() |> int64
            let ay = a.Groups[2].ToString() |> int64
            let b = buttons.Match(Console.In.ReadLine())
            let bx = b.Groups[1].ToString() |> int64
            let by = b.Groups[2].ToString() |> int64
            let p = prize.Match(Console.In.ReadLine())
            let x = p.Groups[1].ToString() |> int64
            let y = p.Groups[2].ToString() |> int64
            Console.In.ReadLine() |> ignore
            let d = 10000000000000L
            main (result + solve (x + d) (y + d) ax ay bx by)

printfn "%d" (main 0L)
