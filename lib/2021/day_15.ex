defmodule AdventOfCode.Y2021.Day15 do
  defp coords(raw_input, expand?) do
    lines = String.split(raw_input, "\n", trim: true)
    count = length(lines)

    lines
    |> Stream.map(fn line ->
      String.graphemes(line)
      |> Stream.map(&String.to_integer/1)
      |> Enum.with_index()
    end)
    |> Stream.with_index()
    |> Enum.map(fn {x_s, y} ->
      Enum.map(x_s, fn
        {weight, x} ->
          if expand?,
            do: expand({x, y}, weight, count),
            else: {{x, y}, weight}
      end)
    end)
    |> List.flatten()
    |> Map.new()
  end

  defp expand({x, y}, weight, count) do
    for i <- 0..4, j <- 0..4 do
      w = weight + i + j
      w = if w > 9, do: w - 9, else: w
      {{x + count * i, y + count * j}, w}
    end
  end

  defp graph(coords) do
    coords
    |> Enum.reduce(
      Graph.new(vertex_identifier: & &1),
      fn {coord, _weight}, graph ->
        adjescant(coord)
        |> Enum.filter(&Map.has_key?(coords, &1))
        |> Enum.map(fn c ->
          weight = Map.get(coords, c, nil)
          Graph.Edge.new(coord, c, weight: weight)
        end)
        |> then(fn edges -> Graph.add_edges(graph, edges) end)
      end
    )
  end

  defp adjescant({x, y}) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
  end

  defp solve(graph) do
    {start, destination} = Enum.min_max(Graph.vertices(graph))
    Graph.Pathfinding.dijkstra(graph, start, destination)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [v1, v2], acc ->
      edge = Graph.edge(graph, v1, v2)
      Map.get(edge, :weight) + acc
    end)
  end

  def part1(args), do: coords(args, false) |> graph() |> solve()
  def part2(args), do: coords(args, true) |> graph() |> solve()
end
