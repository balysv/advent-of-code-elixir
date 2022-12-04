defmodule AdventOfCode.Y2021.Day06 do

  defp prepare_input(raw_input) do
    raw_input
    |> String.trim("\n")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def part1(args) do
    prepare_input(args) |> calculate(80)
  end

  def part2(args) do
    prepare_input(args) |> calculate(256)
  end

  defp calculate(input, days) do
    input
    |> Enum.frequencies()
    |> recur(days)
    |> Map.values()
    |> Enum.sum()
  end

  defp recur(fishes, 0), do: fishes
  defp recur(fishes, days) do
    fishes
    |> Enum.reduce(%{}, &update_fishes/2)
    |> recur(days - 1)
  end

  def update_fishes({0, num}, acc) do
    acc
    |> Map.update(6, num, &(&1 + num))
    # roll-over to 8
    |> Map.put(8, num)
  end

  def update_fishes({timer, num}, acc) do
    Map.update(acc, timer - 1, num, &(num + &1))
  end
end
