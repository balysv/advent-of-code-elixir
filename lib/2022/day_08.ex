defmodule AdventOfCode.Y2022.Day08 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.map(fn {tree, x} -> {{x, y}, tree} end)
    end)
    |> Map.new()
  end

  defp min_max_coords(trees) do
    {{max_x, _}, _} = Enum.max_by(trees, fn {{x, _}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(trees, fn {{_, y}, _} -> y end)
    {max_x, max_y}
  end

  defp visible_in_ranges(c1_range, c2_range, dir, trees) do
    c1_range
    |> Enum.map(&visible_in_line(c2_range, &1, dir, trees))
    |> Enum.concat()
  end

  defp visible_in_line(c_range, c2, dir, trees) do
    c_range
    |> Enum.reduce({-1, []}, fn c1, {tallest, v} ->
      coord = coord(c1, c2, dir)
      tree = Map.get(trees, coord)
      tall = max(tree, tallest)

      if tree > tallest,
        do: {tall, [coord | v]},
        else: {tall, v}
    end)
    |> elem(1)
  end

  defp count_visible_from_house(c_range, c2, dir, house, trees) do
    c_range
    |> Enum.reduce_while({house, []}, fn c1, {house, v} ->
      coord = coord(c1, c2, dir)
      tree = Map.get(trees, coord)

      if tree >= house,
        do: {:halt, {house, [coord | v]}},
        else: {:cont, {house, [coord | v]}}
    end)
    |> elem(1)
    |> Enum.count()
  end

  defp coord(c1, c2, :x), do: {c2, c1}
  defp coord(c1, c2, :y), do: {c1, c2}

  def part1(args) do
    trees = prepare_input(args)
    {max_x, max_y} = min_max_coords(trees)

    Enum.concat([
      visible_in_ranges(0..max_x, 0..max_y, :x, trees),
      visible_in_ranges(0..max_x, max_y..0, :x, trees),
      visible_in_ranges(0..max_y, 0..max_x, :y, trees),
      visible_in_ranges(0..max_y, max_x..0, :y, trees)
    ])
    |> MapSet.new()
    |> MapSet.size()
  end

  def part2(args) do
    trees = prepare_input(args)
    {max_x, max_y} = min_max_coords(trees)

    for x <- 1..(max_x - 1), y <- 1..(max_y - 1) do
      house = Map.get(trees, {x, y})

      Enum.product([
        count_visible_from_house((x - 1)..0, y, :y, house, trees),
        count_visible_from_house((x + 1)..max_x, y, :y, house, trees),
        count_visible_from_house((y - 1)..0, x, :x, house, trees),
        count_visible_from_house((y + 1)..max_y, x, :x, house, trees)
      ])
    end
    |> Enum.max()
  end
end
