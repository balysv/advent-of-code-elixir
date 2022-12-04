defmodule AdventOfCode.Y2021.Day09 do
  defp prepare_input(raw_input) do
    raw_input
    |> String.splitter("\n", trim: true)
    |> Stream.map(fn line ->
      String.graphemes(line)
      |> Stream.map(&String.to_integer/1)
      |> Enum.with_index()
    end)
    |> Stream.with_index()
    |> Enum.map(fn {list, y} ->
      Enum.map(list, fn {value, x} -> {{x, y}, value} end)
    end)
    |> List.flatten()
    |> Map.new()
  end

  def part1(args) do
    coords = prepare_input(args)

    low_points(coords)
    |> Stream.map(fn {{_, _}, value} -> value + 1 end)
    |> Enum.sum()
  end

  def part2(args) do
    coords = prepare_input(args)

    low_points = low_points(coords)

    low_points
    |> Stream.map(fn {{x, y}, _} -> [{x, y}] end)
    |> Stream.map(&recur(&1, coords, [], 0))
    |> Enum.sort()
    |> Enum.slice(-3, 3)
    |> Enum.product()
  end

  defp low_points(coords) do
    # deltas = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]

    coords
    |> Stream.reject(fn {{x, y}, value} ->
      # THIS IS FAST-er:
      coords[{x + 1, y}] <= value or
        coords[{x - 1, y}] <= value or
        coords[{x, y + 1}] <= value or
        coords[{x, y - 1}] <= value

      # THIS IS SLOW:
      # deltas
      # |> Stream.map(fn {dx, dy} -> coords[{x + dx, y + dy}] <= value end)
      # |> Enum.any?()
    end)
  end

  defp recur([], _, _, acc), do: acc

  defp recur([coord = {x, y} | rest], coords, seen, acc) do
    expanded_coords =
      [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]
      |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)

    to_check =
      expanded_coords
      |> Enum.filter(fn coord ->
        coord not in seen and coords[coord] != nil and coords[coord] != 9
      end)

    recur(to_check ++ rest, coords, ([coord] ++ expanded_coords) ++ seen, acc + 1)
  end
end
