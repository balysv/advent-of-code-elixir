defmodule AdventOfCode.Y2016.Day13 do
  @input 1364

  def part1() do
    bfs([{1, 1}], available_moves({1, 1}), [], 0)
  end

  def part2() do
    bfs([{1, 1}], available_moves({1, 1}), [], 0)
  end

  # P1 output
  defp bfs([{31, 39} | rest], _, _, steps), do: steps

  # P2 output
  # defp bfs(_, _, visited, 51), do: length(visited)

  defp bfs([], neighbours, visited, steps), do: bfs(neighbours, [], visited, steps + 1)

  defp bfs([curr | rest], neighbours, visited, steps) do
    cond do
      curr in visited ->
        bfs(rest, neighbours, visited, steps)

      true ->
        new_moves = available_moves(curr)
        bfs(rest, neighbours ++ new_moves, [curr | visited], steps)
    end
  end

  defp available_moves({x, y}) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
    |> Enum.reject(fn {x, y} -> x < 0 or y < 0 end)
    |> Enum.reject(&wall?/1)
  end

  def wall?({x, y}) do
    decimal = x * x + 3 * x + 2 * x * y + y + y * y + @input

    number_of_1s =
      decimal
      |> Integer.to_string(2)
      |> String.graphemes()
      |> Enum.frequencies()
      |> Map.get("1")

    rem(number_of_1s, 2) == 1
  end
end
