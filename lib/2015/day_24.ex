defmodule AdventOfCode.Y2015.Day24 do
  def part1(args), do: solve(args, 3)
  def part2(args), do: solve(args, 4)

  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end

  defp solve(args, count) do
    packages = prepare_input(args)
    group_weight = div(Enum.sum(packages), count)

    packages
    |> permutations(0, group_weight)
    |> Enum.group_by(&length/1)
    |> Enum.sort()
    |> Enum.take(1)
    |> hd()
    |> elem(1)
    |> Enum.map(&Enum.product/1)
    |> Enum.min()
  end

  defp permutations(_, sum, t) when sum > t, do: [[]]

  defp permutations(list, sum, t) when sum == t, do: [list]

  defp permutations(list, sum, t) do
    for {elem, idx} <- Enum.with_index(list),
        s = sum + elem,
        s <= t,
        rest <- permutations(Enum.slice(list, (idx + 1)..-1), s, t) do
      [elem | rest]
    end
  end
end
