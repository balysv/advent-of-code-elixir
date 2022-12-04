defmodule AdventOfCode.Y2022.Day03 do
  defp priority(item) do
    if item >= 97, do: item - 96, else: item - 64 + 26
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      mid = round(String.length(line) / 2)
      {f, s} = line |> String.to_charlist() |> Enum.split(mid)

      MapSet.intersection(MapSet.new(f), MapSet.new(s))
      |> MapSet.to_list()
      |> List.first()
      |> priority()
    end)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      group
      |> Enum.map(&String.to_charlist/1)
      |> Enum.map(&MapSet.new/1)
      |> Enum.reduce(&MapSet.intersection(&2, &1))
      |> MapSet.to_list()
      |> List.first()
      |> priority()
    end)
    |> Enum.sum()
  end
end
