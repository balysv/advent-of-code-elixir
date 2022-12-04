defmodule AdventOfCode.Y2015.Day11 do
  @end_ 122
  @start 97

  def part1(args), do: args |> String.to_charlist() |> solve()

  def part2(args), do: args |> String.to_charlist() |> next_pass() |> solve()

  defp solve(input) do
    1..10_000_000
    |> Enum.reduce_while(input, fn
      _, pass ->
        good = good_letters?(pass) and inc_letters?(pass) and dupl_letters?(pass)

        if good do
          {:halt, pass}
        else
          {:cont, next_pass(pass)}
        end
    end)
  end

  defp good_letters?(pass), do: !(?i in pass or ?o in pass or ?l in pass)

  defp inc_letters?(pass),
    do:
      pass
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.any?(fn [a, b, c] -> b - a == 1 and c - b == 1 end)

  defp dupl_letters?(pass),
    do:
      pass
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.filter(fn [a, b] -> a == b end)
      |> Enum.uniq()
      |> length() > 1

  defp next_pass(pass) do
    pass
    |> Enum.reverse()
    |> Enum.reduce({[], 1}, fn
      c, {r, 1} when c + 1 > @end_ -> {[@start | r], 1}
      c, {r, 1} -> {[c + 1 | r], 0}
      c, {r, 0} -> {[c | r], 0}
    end)
    |> then(&elem(&1, 0))
  end
end
