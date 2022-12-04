defmodule AdventOfCode.Y2016.Day01 do
  @north 0
  @west 1
  @south 2
  @east 3

  defp prepare_input(raw), do: String.split(raw, [",", " ", "\n"], trim: true)

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.reduce({{0, 0}, @north}, fn
      <<d::bytes-size(1)>> <> v, {loc, f} ->
        a = String.to_integer(v)
        f = dir(f, d)
        new_loc = move(f, a, loc)
        {new_loc, f}
    end)
    |> elem(0)
    |> manhattan({0, 0})
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.reduce_while({{0, 0}, @north, MapSet.new()}, fn
      <<d::bytes-size(1)>> <> v, {loc = {x, y}, f, visited} ->
        a = String.to_integer(v)
        f = dir(f, d)
        new_loc = {nx, ny} = move(f, a, loc)

        all_locs = for xx <- x..nx, yy <- y..ny, {xx, yy}, {xx, yy} != loc, do: {xx, yy}
        already_visited = all_locs |> Enum.filter(&MapSet.member?(visited, &1))
        visited = Enum.reduce(all_locs, visited, &MapSet.put(&2, &1))

        if length(already_visited) > 0 do
          {:halt, {hd(already_visited), f, visited}}
        else
          {:cont, {new_loc, f, visited}}
        end
    end)
    |> elem(0)
    |> manhattan({0, 0})
  end

  defp move(@west, a, {x, y}), do: {x - a, y}
  defp move(@south, a, {x, y}), do: {x, y - a}
  defp move(@north, a, {x, y}), do: {x, y + a}
  defp move(@east, a, {x, y}), do: {x + a, y}

  defp dir(f, "L"), do: rem(f + 1, 4)
  defp dir(0, "R"), do: 3
  defp dir(f, "R"), do: f - 1

  def manhattan({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)
end
