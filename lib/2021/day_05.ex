defmodule AdventOfCode.Y2021.Day05 do
  def prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn t -> String.split(t, " -> ")
      |> Enum.map(&String.split(&1, ",")
      |> Enum.map(fn t-> String.to_integer(t) end)
      |> List.to_tuple)
    end)
  end

  def delta({a, b}) do
    d = a - b
    if d == 0, do: 0, else: round(d / abs(d) * -1)
  end

  def part1(args) do
    prepare_input(args)
    # No diagonals
    |> Enum.filter(fn [{x1, y1}, {x2, y2}] -> x1 == x2 or y1 == y2 end)
    |> Enum.map(&expand_vent_coords/1)
    |> count_intersecting_coords
  end

  def part2(args) do
    prepare_input(args)
    |> Enum.map(&expand_vent_coords/1)
    |> count_intersecting_coords
  end

  defp expand_vent_coords([{x1, y1}, {x2, y2}]) do
      {dx, dy} = {delta({x1, x2}), delta({y1, y2})}
      length = if x1 != x2, do: abs(x1 - x2), else: abs(y1 - y2)
      Enum.map(0..length, &{x1 + &1 * dx, y1 + &1 * dy})
  end

  defp count_intersecting_coords(vent_coords) do
    vent_coords
    |> List.flatten
    |> Enum.frequencies
    |> Map.to_list
    |> Enum.count(fn {{_, _}, count} -> count > 1 end)
  end
end
