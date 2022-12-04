defmodule AdventOfCode.Y2021.Day12 do
  def prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn nodes, acc ->
      [a, b] = String.split(nodes, "-")

      acc
      |> Map.update(a, [b], &([b | &1]))
      |> Map.update(b, [a], &([a | &1]))
    end)
  end

  def part1(args) do
    connections = prepare_input(args)

    Map.get(connections, "start")
    |> find_all_paths(connections, true, ["start"])
  end

  def part2(args) do
    connections = prepare_input(args)

    Map.get(connections, "start")
    |> find_all_paths(connections, false, ["start"])
  end

  defp find_all_paths([], _, _, _), do: 0

  defp find_all_paths(["start" | vertices], connections, small_cave_explored, curr_path) do
    find_all_paths(vertices, connections, small_cave_explored, curr_path)
  end

  defp find_all_paths(["end" | vertices], connections, small_cave_explored, curr_path) do
    1 + find_all_paths(vertices, connections, small_cave_explored, curr_path)
  end

  defp find_all_paths([vertex | vertices], connections, small_cave_explored, curr_path) do
    new_paths =
      cond do
        lowercase?(vertex) and vertex in curr_path and small_cave_explored ->
          0

        lowercase?(vertex) and vertex in curr_path and !small_cave_explored ->
          Map.get(connections, vertex)
          |> find_all_paths(connections, true, [vertex | curr_path])

        true ->
          Map.get(connections, vertex)
          |> find_all_paths(connections, small_cave_explored, [vertex | curr_path])
      end

    new_paths + find_all_paths(vertices, connections, small_cave_explored, curr_path)
  end

  defp lowercase?(s), do: String.downcase(s) == s
end
