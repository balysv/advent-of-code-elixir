defmodule AdventOfCode.Y2019.Day01 do
  defp prepare_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp fuel(m), do: div(m, 3) - 2
  defp rec_fuel(m), do: rec_fuel(m, 0)
  defp rec_fuel(m, acc) when m < 9, do: acc
  defp rec_fuel(m, acc), do: rec_fuel(fuel(m), acc + fuel(m))

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.map(&fuel/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.map(&rec_fuel/1)
    |> Enum.sum()
  end
end
