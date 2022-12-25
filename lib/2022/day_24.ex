defmodule AdventOfCode.Y2022.Day24 do
  defmodule PQ do
    def new(priority, value), do: add(%{}, priority, value)

    def add(pq, priority, value), do: Map.update(pq, priority, [value], &(&1 ++ [value]))

    def next(pq) do
      case Enum.min(pq) do
        {priority, [value]} -> {priority, value, Map.delete(pq, priority)}
        {priority, [value | rest]} -> {priority, value, Map.put(pq, priority, rest)}
      end
    end
  end

  defp prepare_input(args) do
    map =
      args
      |> String.split("\n", trim: true)
      |> Enum.with_index(1)
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.graphemes()
        |> Enum.with_index(1)
        |> Enum.reject(&match?({".", _}, &1))
        |> Enum.reject(&match?({"#", _}, &1))
        |> Enum.map(fn {chr, x} -> {{x, y}, [chr]} end)
      end)
      |> Map.new()

    max_x = max_x(map)
    max_y = max_y(map)

    {map, {2, 1}, {max_x, max_y + 1}, {max_x + 1, max_y + 1}}
  end

  defp max_x(map), do: map |> Enum.map(&elem(&1, 0)) |> Enum.map(&elem(&1, 0)) |> Enum.max()
  defp max_y(map), do: map |> Enum.map(&elem(&1, 0)) |> Enum.map(&elem(&1, 1)) |> Enum.max()

  defp do_move({x, y}, ">"), do: {x + 1, y}
  defp do_move({x, y}, "<"), do: {x - 1, y}
  defp do_move({x, y}, "v"), do: {x, y + 1}
  defp do_move({x, y}, "^"), do: {x, y - 1}

  defp step(grid, {width, height}) do
    Enum.reduce(grid, %{}, fn {{x, y}, list}, g ->
      Enum.reduce(list, g, fn gust, g ->
        {dx, dy} = do_move({x, y}, gust)

        x =
          case dx do
            1 -> width - 1
            ^width -> 2
            x -> x
          end

        y =
          case dy do
            1 -> height - 1
            ^height -> 2
            y -> y
          end

        Map.update(g, {x, y}, [gust], &[gust | &1])
      end)
    end)
  end

  defp manhattan({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  defp find_moves(map, {px, py} = pos, turn, {max_x, max_y}, dest) do
    [pos, {px + 1, py}, {px - 1, py}, {px, py + 1}, {px, py - 1}]
    |> Enum.filter(fn {x, y} ->
      {x, y} in [dest, pos] or (x > 1 and x < max_x and y > 1 and y < max_y)
    end)
    |> Enum.filter(fn coord -> Map.get(map, coord, []) == [] end)
    |> Enum.map(fn move -> {move, turn} end)
  end

  defp get_map(turn, ets_pid, dims) do
    case :ets.lookup(ets_pid, {:map, turn}) do
      [{_, v}] ->
        v

      _ ->
        [{_, map}] = :ets.lookup(ets_pid, {:map, turn - 1})
        map = step(map, dims)
        :ets.insert(ets_pid, {{:map, turn}, map})
        map
    end
  end

  defp simulate(pq, dest, ets_pid, visited, dims) do
    {_, {pos, turn}, pq} = PQ.next(pq)

    if pos == dest do
      turn
    else
      map = get_map(turn + 1, ets_pid, dims)

      new_moves =
        map
        |> find_moves(pos, turn + 1, dims, dest)
        |> Enum.reject(&(&1 in visited))

      visited = MapSet.union(visited, MapSet.new(new_moves))

      pq =
        Enum.reduce(new_moves, pq, fn {move, turn}, pq ->
          PQ.add(pq, turn + manhattan(move, dest), {move, turn})
        end)

      simulate(pq, dest, ets_pid, visited, dims)
    end
  end

  def part1(args) do
    {map, start, dest, dims} = prepare_input(args)

    ets_pid = :ets.new(:cache, [:set, :public])
    :ets.insert(ets_pid, {{:map, 0}, map})

    simulate(PQ.new(manhattan(start, dest), {start, 0}), dest, ets_pid, MapSet.new([start]), dims)
  end

  def part2(args) do
    {map, start, dest, dims} = prepare_input(args)

    ets_pid = :ets.new(:cache, [:set, :public])
    :ets.insert(ets_pid, {{:map, 0}, map})

    dist = manhattan(start, dest)
    turn1 = simulate(PQ.new(dist, {start, 0}), dest, ets_pid, MapSet.new([start]), dims)
    turn2 = simulate(PQ.new(dist, {dest, turn1}), start, ets_pid, MapSet.new([start]), dims)
    simulate(PQ.new(dist, {start, turn2}), dest, ets_pid, MapSet.new([start]), dims)
  end
end
