defmodule AdventOfCode.Y2016.Day08 do
  @max_x 49
  @max_y 5

  defp prepare_input(raw) do
    instr = raw |> String.split("\n", trim: true)

    screen =
      for x <- 0..@max_x, y <- 0..@max_y, reduce: %{} do
        acc -> Map.put(acc, {x, y}, ".")
      end

    {instr, screen}
  end

  def part1(args) do
    {instr, screen} = args |> prepare_input()
    recur(instr, screen) |> Enum.count(fn {_, v} -> v == "#" end)
  end

  def part2(args) do
    {instr, screen} = args |> prepare_input()
    recur(instr, screen) |> print()
  end

  defp recur([], screen), do: screen

  defp recur(["rect " <> dims | rest], screen) do
    [ex, ey] = dims |> String.split("x") |> Enum.map(&String.to_integer/1)

    screen =
      for x <- 0..(ex - 1), y <- 0..(ey - 1), reduce: screen do
        acc -> Map.put(acc, {x, y}, "#")
      end

    recur(rest, screen)
  end

  defp recur(["rotate column x=" <> str | rest], screen) do
    [col, val] = str |> String.split(" by ") |> Enum.map(&String.to_integer/1)

    screen =
      for y <- 0..@max_y, reduce: screen do
        acc ->
          current = Map.get(screen, {col, y})
          Map.put(acc, {col, rem(y + val, @max_y + 1)}, current)
      end

    recur(rest, screen)
  end

  defp recur(["rotate row y=" <> str | rest], screen) do
    [row, val] = str |> String.split(" by ") |> Enum.map(&String.to_integer/1)

    screen =
      for x <- 0..@max_x, reduce: screen do
        acc ->
          current = Map.get(screen, {x, row})
          Map.put(acc, {rem(x + val, @max_x + 1), row}, current)
      end

    recur(rest, screen)
  end

  defp print(screen) do
    max_x = @max_x
    max_y = @max_y

    IO.puts("")

    for y <- 0..max_y, x <- 0..max_x do
      IO.write(Map.get(screen, {x, y}))
      if x == max_x, do: IO.puts("")
    end
  end
end
