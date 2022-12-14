defmodule AdventOfCode.Y2022.Day14 do
  defp prepare_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split([",", " -> "])
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.chunk_every(2, 1, :discard)
    end)
    |> Enum.flat_map(&rock_coords/1)
    |> Map.new()
  end

  defp rock_coords(rocks) do
    Enum.flat_map(rocks, fn [[sx, sy], [ex, ey]] ->
      for x <- sx..ex, y <- sy..ey, do: {{x, y}, "#"}
    end)
  end

  defp new_sand_position({x, y}, cave) do
    [{x, y + 1}, {x - 1, y + 1}, {x + 1, y + 1}]
    |> Enum.find(:rest, fn coords -> not Map.has_key?(cave, coords) end)
  end

  defp count_sand_in_rest(cave) do
    Enum.count(cave, fn {_, space} -> space == "O" end)
  end

  @new_sand {500, 0}

  def part1(args) do
    cave = prepare_input(args)
    {{_, cave_depth}, _} = Enum.max_by(cave, fn {{_, y}, _} -> y end)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({cave, @new_sand}, fn
      _, {cave, grain} ->
        case new_sand_position(grain, cave) do
          {_x, y} when y > cave_depth ->
            {:halt, cave}

          :rest ->
            {:cont, {Map.put(cave, grain, "O"), @new_sand}}

          coords ->
            {:cont, {cave, coords}}
        end
    end)
    |> count_sand_in_rest()
  end

  def part2(args) do
    cave = prepare_input(args)
    {{_, cave_depth}, _} = Enum.max_by(cave, fn {{_, y}, _} -> y end)
    cave = Enum.reduce(-1000..1000, cave, &Map.put(&2, {&1, cave_depth + 2}, "#"))

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({cave, @new_sand}, fn
      _, {cave, grain} ->
        case new_sand_position(grain, cave) do
          :rest ->
            cave = Map.put(cave, grain, "O")

            if grain == @new_sand,
              do: {:halt, cave},
              else: {:cont, {cave, @new_sand}}

          coords ->
            {:cont, {cave, coords}}
        end
    end)
    |> count_sand_in_rest()
  end

  defp print(cave, grain) do
    {{min_x, _}, _} = Enum.min_by(cave, fn {{x, _}, _} -> x end)
    {{max_x, _}, _} = Enum.max_by(cave, fn {{x, _}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(cave, fn {{_, y}, _} -> y end)

    IO.puts("\n")

    for y <- 0..max_y, x <- (min_x - 1)..(max_x + 1) do
      if {x, y} == grain do
        IO.write(Map.get(cave, {x, y}, "o"))
      else
        IO.write(Map.get(cave, {x, y}, "."))
      end

      if x > max_x, do: IO.puts("")
    end

    Process.sleep(16)
    IEx.Helpers.clear()
  end
end
