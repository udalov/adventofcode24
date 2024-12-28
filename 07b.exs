# elixir 07b.exs

defmodule Solution do
    def go(r, a) do
        [first | rest] = a
        if rest == [] do
            r == first
        else
            go(r - first, rest) or
                (rem(r, first) == 0 and go(div(r, first), rest)) or
                concat(r, first, rest)
        end
    end

    def concat(r, first, rest) do
        x = Integer.to_string(r)
        y = Integer.to_string(first)
        x != y and String.ends_with?(x, y) and
            go(elem(Integer.parse(String.slice(x, 0, String.length(x) - String.length(y))), 0), rest)
    end

    def solve(lines) do
        List.foldl(lines, 0, fn line, result ->
            [r | a] = line
            result + (if go(r, Enum.reverse(a)) do r else 0 end)
        end)
    end

    def main() do
        input = IO.read(:stdio, :eof)
            |> String.trim()
            |> String.split("\n")
            |> Enum.map(fn line -> String.split(line, ~r/[^\d]+/) end)
            |> Enum.map(fn strs ->
                Enum.map(strs, fn str -> elem(Integer.parse(str), 0) end)
               end)
        IO.inspect(solve(input))
    end
end

Solution.main()
