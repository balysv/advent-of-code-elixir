defmodule AdventOfCode.Y2022.Day23 do
  defp prepare_input(args) do
    e =
      String.duplicate(
        ".........................................................................\n",
        5
      )

    args = e <> args <> e

    args
    |> String.split("\n", trim: true)
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {line, y} ->
      line = ".........." <> line <> ".........."

      line
      |> String.graphemes()
      |> Enum.with_index(1)
      |> Enum.map(fn {chr, x} ->
        {{x + 10, y + 10}, chr}
      end)
    end)
    |> Map.new()
  end

  defp add_delta({x, y}, {dx, dy}), do: {x + dx, y + dy}

  defp adjescant(pos) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}]
    |> Enum.map(&add_delta(&1, pos))
  end

  @dirs [
    [{-1, -1}, {0, -1}, {1, -1}],
    [{1, 1}, {0, 1}, {-1, 1}],
    [{-1, 1}, {-1, 0}, {-1, -1}],
    [{1, -1}, {1, 0}, {1, 1}]
  ]

  @deltas [{0, -1}, {0, 1}, {-1, 0}, {1, 0}]

  defp add_deltas(dirs, pos), do: dirs |> Enum.map(&add_delta(&1, pos))

  defp has_elf?(pos), do: match?({_, "#"}, pos)
  defp is_elf?(char), do: char == "#"

  defp moving_elfs(map) do
    map
    |> Enum.filter(&has_elf?(&1))
    |> Enum.filter(fn {pos, _} ->
      adjescant(pos)
      |> Enum.map(&Map.get(map, &1, "."))
      |> Enum.any?(&is_elf?/1)
    end)
    |> Enum.map(&elem(&1, 0))
  end

  defp proposed_moves(moving_elfs, turn) do
    dirs =
      (@dirs ++ @dirs)
      |> Enum.drop(rem(turn, 4))
      |> Enum.take(4)

    deltas =
      (@deltas ++ @deltas)
      |> Enum.drop(rem(turn, 4))
      |> Enum.take(4)

    Enum.map(moving_elfs, fn pos ->
      cond do
        length(add_deltas(Enum.at(dirs, 0), pos) -- moving_elfs) == 3 ->
          {pos, add_delta(pos, Enum.at(deltas, 0))}

        length(add_deltas(Enum.at(dirs, 1), pos) -- moving_elfs) == 3 ->
          {pos, add_delta(pos, Enum.at(deltas, 1))}

        length(add_deltas(Enum.at(dirs, 2), pos) -- moving_elfs) == 3 ->
          {pos, add_delta(pos, Enum.at(deltas, 2))}

        length(add_deltas(Enum.at(dirs, 3), pos) -- moving_elfs) == 3 ->
          {pos, add_delta(pos, Enum.at(deltas, 3))}

        true ->
          {pos, :stay}
      end
    end)
  end

  defp move_elfs(map, proposed_moves) do
    proposed_trgs = proposed_moves |> Enum.map(&elem(&1, 1)) |> Enum.frequencies()

    proposed_moves
    |> Enum.reject(fn {_, trgt} -> trgt == :stay end)
    |> Enum.reduce(map, fn {old, new}, map ->
      if Map.get(proposed_trgs, new) > 1 do
        map
      else
        map
        |> Map.put(new, "#")
        |> Map.put(old, ".")
      end
    end)
  end

  def part1(args) do
    map = prepare_input(args)

    map =
      0..9
      |> Enum.reduce(map, fn turn, map ->
        moving_elfs = moving_elfs(map)
        proposed_moves = proposed_moves(moving_elfs, turn)
        move_elfs(map, proposed_moves)
      end)

    elfs = Enum.filter(map, &has_elf?(&1))

    {{min_x, _}, {max_x, _}} = elfs |> Enum.map(&elem(&1, 0)) |> Enum.min_max_by(&elem(&1, 0))

    {{_, min_y}, {_, max_y}} = elfs |> Enum.map(&elem(&1, 0)) |> Enum.min_max_by(&elem(&1, 1))

    (max_x - min_x + 1) * (max_y - min_y + 1) - length(elfs)
  end

  def part2(args) do
    map = prepare_input(args)

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(map, fn turn, map ->
      IO.inspect(turn)
      moving_elfs = moving_elfs(map)
      proposed_moves = proposed_moves(moving_elfs, turn)
      new_map = move_elfs(map, proposed_moves)

      if map == new_map do
        {:halt, turn}
      else
        {:cont, new_map}
      end
    end)
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

    IO.write(r)
    IO.write("\n")
    IO.write("\n")
    :timer.sleep(500)
  end
end
