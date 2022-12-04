defmodule AdventOfCode.Y2015.Day18 do
  defp prepare_input(raw) do
    lines = raw |> String.split("\n", trim: true)

    grid =
      for {line, y} <- Enum.with_index(lines),
          {char, x} <- String.graphemes(line) |> Enum.with_index() do
        {{x, y}, char}
      end

    grid |> Enum.into(%{})
  end

  def part1(args) do
    grid = args |> prepare_input()

    1..100
    |> Enum.reduce(grid, fn _, acc -> step(acc) end)
    |> Enum.count(fn {_, s} -> s == "#" end)
  end

  def part2(args) do
    grid = args |> prepare_input() |> fix_lights()

    1..1_000_000
    |> Enum.reduce(grid, fn _, acc ->
      print(acc)
      step(acc, false)
    end)
    |> Enum.count(fn {_, s} -> s == "#" end)
  end

  defp step(grid, p2? \\ false) do
    grid
    |> Enum.map(fn
      {coord, "#"} ->
        count =
          neighbours(coord)
          |> Enum.count(fn c -> Map.get(grid, c, ".") == "#" end)

        if count == 2 or count == 3, do: {coord, "#"}, else: {coord, "."}

      {coord, "."} ->
        count =
          neighbours(coord)
          |> Enum.count(fn c -> Map.get(grid, c, ".") == "#" end)

        if count == 3, do: {coord, "#"}, else: {coord, "."}
    end)
    |> Enum.into(%{})
    |> then(fn i -> if p2?, do: fix_lights(i), else: i end)
  end

  defp neighbours({x, y}) do
    for a <- (x - 1)..(x + 1),
        b <- (y - 1)..(y + 1),
        {a, b} != {x, y},
        do: {a, b}
  end

  defp fix_lights(grid) do
    grid
    |> Map.put({0, 0}, "#")
    |> Map.put({99, 0}, "#")
    |> Map.put({99, 99}, "#")
    |> Map.put({0, 99}, "#")
  end

  defp print(grid) do
    t = ""
    {{max_x, _}, _} = Enum.max_by(grid, &elem(&1, 0))

    r =
      for {{x, _}, v} <-
            grid |> Enum.sort_by(fn {{x, _}, _} -> x end) |> Enum.sort_by(fn {{_, y}, _} -> y end) do
        t = t <> v
        if x == max_x, do: t <> "\n", else: t
      end

    # IEx.Helpers.clear()
    IO.puts("")
    IO.write(r)
    :timer.sleep(10)
  end
end
