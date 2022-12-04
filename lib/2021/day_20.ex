defmodule AdventOfCode.Y2021.Day20 do
  defp prepare_input(raw_input) do
    [algo, image] = raw_input |> String.split("\n\n", trim: true)

    image_lines =
      image
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> String.graphemes(s) |> Enum.with_index() end)
      |> Enum.with_index()

    grid =
      for {line, y} <- image_lines, {pixel, x} <- line, into: %{} do
        {{x, y}, pixel}
      end

    {algo |> String.graphemes(), grid}
  end

  def part1(args) do
    {algo, grid} = args |> prepare_input()
    count_pixels(algo, grid, 2)
  end

  def part2(args) do
    {algo, grid} = args |> prepare_input()
    count_pixels(algo, grid, 50)
  end

  defp count_pixels(algo, grid, turns) do
    {{{min_x, min_y}, _}, {{max_x, max_y}, _}} = Enum.min_max_by(grid, fn {key, _} -> key end)

    xs = Enum.chunk_every((min_x - turns * 2)..(max_x + turns * 2), 3, 1, :discard)
    ys = Enum.chunk_every((min_y - turns * 2)..(max_y + turns * 2), 3, 1, :discard)

    image_xs = (min_x - turns)..(max_x + turns)
    image_ys = (min_y - turns)..(max_y + turns)

    Enum.reduce(1..turns, grid, fn _, acc -> turn(algo, acc, xs, ys) end)
    |> Enum.count(fn {{x, y}, v} -> x in image_xs and y in image_ys and v == "#" end)
  end

  defp turn(algo, grid, xs, ys) do
    for [x1, x2, x3] <- xs, [y1, y2, y3] <- ys, into: %{} do
      symbol =
        [{x1, y1}, {x2, y1}, {x3, y1}, {x1, y2}, {x2, y2}, {x3, y2}, {x1, y3}, {x2, y3}, {x3, y3}]
        |> Enum.reduce([], fn pos, acc ->
          acc ++ [Map.get(grid, pos, ".")]
        end)
        |> Enum.map(fn
          "." -> 0
          "#" -> 1
        end)
        |> Enum.join()
        |> Integer.parse(2)
        |> then(fn {digit, _} -> Enum.at(algo, digit) end)

      {{x2, y2}, symbol}
    end
  end

  defp print(grid, m) do
    {{{min_x, min_y}, _}, {{max_x, max_y}, _}} = Enum.min_max_by(grid, fn {key, _} -> key end)
    IO.puts("")
    for y <- (min_x - m)..(max_x + m), x <- (min_y - m)..(max_y + m) do
      IO.write(Map.get(grid, {x, y}, "."))
      if x == max_x + m, do: IO.puts("")
    end
  end
end
