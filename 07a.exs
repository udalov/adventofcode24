# elixir 07a.exs

defmodule Solution do
    def go(r, a) do
        [first | rest] = a
        if rest == [] do
            r == first
        else
            go(r - first, rest) or (rem(r, first) == 0 and go(div(r, first), rest))
        end
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
