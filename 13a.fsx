// dotnet fsi 13a.fsx

open System
open System.Text.RegularExpressions

let buttons =
    Regex(@"Button [AB]: X\+(\d+), Y\+(\d+)", RegexOptions.Compiled)
let prize =
    Regex(@"Prize: X=(\d+), Y=(\d+)", RegexOptions.Compiled)

let solve x y ax ay bx by =
    let mutable ans = 0
    for na in 0 .. 100 do
        for nb in 0 .. 100 do
            if ax * na + bx * nb = x && ay * na + by * nb = y then
                let cur = 3 * na + nb
                if ans = 0 || ans < cur then
                    ans <- cur
    ans

let rec main result =
    let line = Console.In.ReadLine()
    match line with
        | null -> result
        | some ->
            let a = buttons.Match(some)
            let ax = a.Groups[1].ToString() |> int
            let ay = a.Groups[2].ToString() |> int
            let b = buttons.Match(Console.In.ReadLine())
            let bx = b.Groups[1].ToString() |> int
            let by = b.Groups[2].ToString() |> int
            let p = prize.Match(Console.In.ReadLine())
            let x = p.Groups[1].ToString() |> int
            let y = p.Groups[2].ToString() |> int
            Console.In.ReadLine() |> ignore
            main (result + solve x y ax ay bx by)

printfn "%d" (main 0)
