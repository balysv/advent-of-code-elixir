defmodule AdventOfCode.Y2021.Day01 do
  defp prepare_input(raw_input) do
    raw_input
    |> String.split()
    |> Stream.map(&String.to_integer/1)
  end

  def part1(raw_input) do
    prepare_input(raw_input)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  def part2(raw_input) do
    prepare_input(raw_input)
    |> Stream.chunk_every(4, 1, :discard)
    |> Enum.count(fn [a, _, _, b] -> b > a end)
  end
end
