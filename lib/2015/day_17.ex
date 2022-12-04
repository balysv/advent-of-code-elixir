defmodule AdventOfCode.Y2015.Day17 do
  @target 150

  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end

  def part1(args) do
    args
    |> prepare_input()
    |> permutations(0, 0)
    |> Enum.count(fn {e, _} -> e == 1 end)
  end

  def part2(args) do
    args
    |> prepare_input()
    |> permutations(0, 0)
    |> Enum.filter(fn {e, _} -> e == 1 end)
    |> Enum.frequencies()
    |> Enum.min_by(fn {{1, _}, v} -> v end)
    |> then(fn {_, v} -> v end)
  end

  defp permutations(_, sum, c) when sum > @target, do: [{0, c}]

  defp permutations(_, sum, c) when sum == @target, do: [{1, c}]

  defp permutations(list, sum, c) do
    for {elem, idx} <- Enum.with_index(list),
        s = sum + elem,
        rest <- permutations(Enum.slice(list, (idx + 1)..-1), s, c + 1) do
      rest
    end
  end
end
