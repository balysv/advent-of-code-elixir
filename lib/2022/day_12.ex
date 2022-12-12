defmodule AdventOfCode.Y2022.Day12 do
  defp prepare_input(args) do
    coords =
      args
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.map(fn {char, x} -> {{x, y}, char} end)
      end)
      |> Map.new()

    # destination is 'E' = 69, 'S' = 83
    {dst, _} = Enum.find(coords, &match?({_, 69}, &1))
    {src, _} = Enum.find(coords, &match?({_, 83}, &1))
    # ensure 'S' is an 'a'
    coords = Map.replace(coords, src, 97)

    graph =
      Enum.reduce(
        coords,
        Graph.new(vertex_identifier: & &1),
        fn {coord, _weight}, graph ->
          adjescant(coord)
          |> Enum.filter(&reacheable?(coord, &1, coords))
          |> Enum.map(&Graph.Edge.new(coord, &1, weight: 1))
          |> then(&Graph.add_edges(graph, &1))
        end
      )

    {graph, coords, src, dst}
  end

  defp adjescant({x, y}) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
  end

  defp reacheable?(src, trgt, coords) when is_map_key(coords, trgt) do
    Map.get(coords, trgt) - Map.get(coords, src) <= 1
  end

  defp reacheable?(_, _, _), do: false

  def part1(args) do
    {graph, _, source, destination} = prepare_input(args)
    path = Graph.dijkstra(graph, source, destination)
    length(path) - 1
  end

  def part2(args) do
    {graph, coords, _source, destination} = prepare_input(args)

    coords
    # 'a' = 97
    |> Enum.filter(&match?({_, 97}, &1))
    |> Enum.map(fn {start, _} -> Graph.dijkstra(graph, start, destination) end)
    |> Enum.reject(&is_nil/1)
    |> Enum.map(fn path -> length(path) - 1 end)
    |> Enum.min()
  end
end
