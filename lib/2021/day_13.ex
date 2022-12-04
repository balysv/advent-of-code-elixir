defmodule AdventOfCode.Y2021.Day13 do
  defp prepare_input(raw_input) do
    [raw_coords, raw_instructions] =
      raw_input
      |> String.split(["\n\n"], trim: true)

    grid =
      raw_coords
      |> String.split("\n", trim: true)
      |> Enum.map(fn coord ->
        String.split(coord, ",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
      |> Enum.into(MapSet.new())

    instructions =
      raw_instructions
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        s ->
          [a, b] = String.split(s, "=")
          {String.slice(a, 11..-1), String.to_integer(b)}
      end)

    {instructions, grid}
  end

  def part1(args) do
    {instructions, grid} = prepare_input(args)
    fold([hd(instructions)], grid) |> MapSet.size()
  end

  def part2(args) do
    {instructions, grid} = prepare_input(args)
    fold(instructions, grid) |> print()
  end

  defp fold([], grid), do: grid

  defp fold([{axis, coord} | rest], grid) do
    new_grid =
      grid
      |> Enum.map(fn
        {x, y} when x > coord and axis == "x" -> {coord * 2 - x, y}
        {x, y} when y > coord and axis == "y" -> {x, coord * 2 - y}
        coord -> coord
      end)
      |> Enum.into(MapSet.new())

    fold(rest, new_grid)
  end

  defp print(grid) do
    max_x = 40
    max_y = 10

    IO.puts("")

    for y <- 0..max_y, x <- 0..max_x do
      if MapSet.member?(grid, {x, y}), do: IO.write("##"), else: IO.write("__")
      if x == max_x, do: IO.puts("")
    end
  end
end
