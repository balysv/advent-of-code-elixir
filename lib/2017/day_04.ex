defmodule AdventOfCode.Y2017.Day04 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  defp count_duplicates(passphrases) do
    passphrases
    |> Enum.reduce(%{}, fn i, acc -> Map.update(acc, i, 0, &(&1 + 1)) end)
    |> Map.values()
    |> Enum.sum()
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.map(&count_duplicates(&1))
    |> Enum.count(&(&1 == 0))
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.map(&Enum.map(&1, fn l -> l |> String.to_charlist() |> Enum.sort() |> to_string end))
    |> Enum.map(&count_duplicates(&1))
    |> Enum.count(&(&1 == 0))
  end
end
