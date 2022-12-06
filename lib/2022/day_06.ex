defmodule AdventOfCode.Y2022.Day06 do
  def part1(args) do
    args
    |> String.graphemes()
    |> Enum.chunk_every(4, 1)
    |> Enum.find_index(fn chars -> chars |> MapSet.new() |> MapSet.size() == 4 end)
    |> then(&Kernel.+(&1, 4))
  end

  def part2(args) do
    args
    |> String.graphemes()
    |> Enum.chunk_every(14, 1)
    |> Enum.find_index(fn chars -> chars |> MapSet.new() |> MapSet.size() == 14 end)
    |> then(&Kernel.+(&1, 14))
  end
end
