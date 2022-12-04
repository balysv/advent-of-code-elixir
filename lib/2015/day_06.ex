defmodule AdventOfCode.Y2015.Day06 do
  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "turn on " <> rest -> {:on, parse_coords(rest)}
      "turn off " <> rest -> {:off, parse_coords(rest)}
      "toggle " <> rest -> {:toggle, parse_coords(rest)}
    end)
  end

  defp parse_coords(string) do
    [x1, y1, x2, y2] =
      String.split(string, [",", " through "])
      |> Enum.map(&String.to_integer/1)

    {x1..x2, y1..y2}
  end

  defmodule P1 do
    def process(instrs), do: do_process(instrs, MapSet.new())

    defp do_process([], acc), do: acc

    defp do_process([{action, {xs, ys}} | rest], seen) do
      seen =
        for x <- xs, y <- ys, reduce: seen do
          acc when action == :on ->
            MapSet.put(acc, {x, y})

          acc when action == :off ->
            MapSet.delete(acc, {x, y})

          acc when action == :toggle ->
            c = {x, y}

            if MapSet.member?(acc, c) do
              MapSet.delete(acc, c)
            else
              MapSet.put(acc, c)
            end
        end

      do_process(rest, seen)
    end
  end

  defmodule P2 do
    def process(instrs), do: do_process(instrs, %{})

    defp do_process([], acc), do: acc

    defp do_process([{action, {xs, ys}} | rest], acc) do
      acc =
        for x <- xs, y <- ys, reduce: acc do
          acc when action == :on ->
            Map.update(acc, {x, y}, 1, &(&1 + 1))

          acc when action == :off ->
            Map.update(acc, {x, y}, 0, &(max(&1 - 1, 0)))

          acc when action == :toggle ->
            Map.update(acc, {x, y}, 2, &(&1 + 2))
        end

      do_process(rest, acc)
    end
  end

  def part1(args) do
    args |> prepare_input() |> P1.process() |> MapSet.size()
  end

  def part2(args) do
    args |> prepare_input() |> P2.process() |> Enum.map(fn {{_, _}, v} -> v end) |> Enum.sum()
  end
end
