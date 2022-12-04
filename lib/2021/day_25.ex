defmodule AdventOfCode.Y2021.Day25 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, x} -> {{x, y}, char} end)
    end)
    |> Enum.into(%{})
  end

  def part1(args) do
    grid = args |> prepare_input

    {{max_x, _}, _} = Enum.max_by(grid, fn {{x, _}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(grid, fn {{_, y}, _} -> y end)

    0..10000
    |> Enum.reduce_while(grid, fn i, grid ->
      new_grid =
        grid
        |> process(max_x, max_y, ">")
        |> process(max_x, max_y, "v")

      if grid == new_grid do
        {:halt, i + 1}
      else
        {:cont, new_grid}
      end
    end)
  end

  defp process(grid, max_x, max_y, turn) do
    grid
    |> Enum.reduce(%{}, fn
      {{x, y}, ">"}, acc when turn == ">" ->
        nx = if x == max_x, do: 0, else: x + 1
        move_cucumber(grid, acc, {x, y}, {nx, y}, ">")

      {{x, y}, "v"}, acc when turn == "v" ->
        ny = if y == max_y, do: 0, else: y + 1
        move_cucumber(grid, acc, {x, y}, {x, ny}, "v")

      {k, v}, acc ->
        Map.put_new(acc, k, v)
    end)
  end

  defp move_cucumber(old_grid, new_grid, src, dest, turn) do
    if Map.get(old_grid, dest) == "." do
      new_grid |> Map.put(src, ".") |> Map.put(dest, turn)
    else
      Map.put(new_grid, src, turn)
    end
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

    IEx.Helpers.clear()
    IO.write(r)
    :timer.sleep(25)
  end
end
