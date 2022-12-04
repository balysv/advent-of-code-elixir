defmodule AdventOfCode.Y2021.Day11 do
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
    grid = prepare_input(args)

    {_, count} =
      1..100
      |> Enum.reduce({grid, 0}, fn _, {grid, count} ->
        {new_grid, seen} =
          grid
          |> increment()
          |> flash(MapSet.new())

        {new_grid |> reset, count + MapSet.size(seen)}
      end)

    count
  end

  def part2(args) do
    grid = prepare_input(args)

    1..100_000
    |> Enum.reduce_while(grid, fn c, grid ->
      {new_grid, seen} =
        grid
        |> increment()
        |> flash(MapSet.new())

      if MapSet.size(seen) == 100 do
        {:halt, c}
      else
        {:cont, new_grid |> reset}
      end
    end)
  end

  defp increment(grid) do
    Map.new(grid, fn {k, v} -> {k, v + 1} end)
  end

  defp flash(grid, seen) do
    flashing =
      grid
      |> Enum.filter(fn
        {coords, value} -> value > 9 and !MapSet.member?(seen, coords)
      end)

    if length(flashing) == 0 do
      {grid, seen}
    else
      new_grid =
        flashing
        |> Enum.reduce(grid, fn {coord, _}, acc -> flash_neighbours(coord, acc) end)

      new_seen =
        flashing
        |> Enum.reduce(seen, fn {coords, _}, acc -> MapSet.put(acc, coords) end)

      flash(new_grid, new_seen)
    end
  end

  defp flash_neighbours({x, y}, grid) do
    [{-1, -1}, {-1, 0}, {-1, 1}, {1, 0}, {0, 1}, {1, 1}, {1, -1}, {0, -1}]
    |> Enum.reduce(grid, fn {dx, dy}, acc ->
      n_coord = {x + dx, y + dy}

      if is_map_key(grid, n_coord),
        do: Map.update(acc, n_coord, nil, &(&1 + 1)),
        else: acc
    end)
  end

  defp reset(grid) do
    grid
    |> Map.new(fn
      {k, v} when v > 9 -> {k, 0}
      {k, v} -> {k, v}
    end)
  end
end
