defmodule AdventOfCode.Y2016.Day24 do
  defp coords(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Stream.map(fn line ->
      String.graphemes(line)
      |> Enum.with_index()
    end)
    |> Enum.with_index()
    |> Enum.map(fn {x_s, y} ->
      x_s
      |> Enum.reject(fn {d, _} -> d == "#" end)
      |> Enum.map(fn
        {".", x} -> {{x, y}, false}
        {d, x} -> {{x, y}, d}
      end)
    end)
    |> List.flatten()
    |> Map.new()
  end

  defp graph(coords) do
    coords
    |> Enum.reduce(
      Graph.new(vertex_identifier: & &1),
      fn {coord, _weight}, graph ->
        adjescant(coord)
        |> Enum.filter(&Map.has_key?(coords, &1))
        |> Enum.map(fn c -> Graph.Edge.new(coord, c, weight: 1) end)
        |> then(fn edges -> Graph.add_edges(graph, edges) end)
      end
    )
  end

  defp adjescant({x, y}) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
  end

  defp all_paths(coords) do
    graph = graph(coords)

    targets = Enum.reject(coords, &match?({_, false}, &1))

    for {src, a} <- targets, {dst, b} <- targets, src != dst, reduce: %{} do
      acc ->
        path = Graph.Pathfinding.dijkstra(graph, src, dst) |> length()
        Map.put(acc, {a, b}, path - 1)
    end
  end

  def part1(args) do
    args
    |> coords()
    |> all_paths()
    |> recur("0", ["0"], 0, 999_999, false)
    |> List.flatten()
    |> Enum.min()
  end

  def part2(args) do
    args
    |> coords()
    |> all_paths()
    |> recur("0", ["0"], 0, 999_999, true)
    |> List.flatten()
    |> Enum.min()
  end

  defp recur(paths, curr, visited, curr_cost, min_cost, p2?) when length(visited) == 8 do
    curr_cost =
      if p2? do
        ret_cost = Enum.find(paths, &match?({{^curr, "0"}, _}, &1)) |> elem(1)
        curr_cost + ret_cost
      else
        curr_cost
      end

    if min_cost > curr_cost, do: curr_cost, else: min_cost
  end

  defp recur(paths, curr, visited, curr_cost, min_cost, p2?) do
    dests = Enum.filter(paths, &match?({{^curr, _}, _}, &1))

    for {{_, dst}, cost} <- dests, dst not in visited do
      recur(paths, dst, [dst | visited], curr_cost + cost, min_cost, p2?)
    end
  end
end
