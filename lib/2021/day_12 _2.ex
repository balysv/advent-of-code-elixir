defmodule AdventOfCode.Y2021.Day12_2 do
  use Memoize

  @start 2
  @end_ 3
  @primes [
    5,
    7,
    11,
    13,
    17,
    19,
    23,
    29,
    31,
    37,
    41,
    43,
    47,
    53,
    59,
    61,
    67,
    71,
    73,
    79,
    83,
    89,
    97,
    101,
    103,
    107,
    109,
    113,
    127,
    131,
    137,
    139,
    149,
    151,
    157,
    163,
    167,
    173,
    179,
    181,
    191,
    193,
    197,
    199,
    211,
    223,
    227,
    229,
    233,
    239,
    241,
    251,
    257,
    263,
    269,
    271,
    277,
    281,
    283,
    293,
    307,
    311,
    313,
    317,
    331,
    337,
    347,
    349,
    353,
    359
  ]

  def prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn nodes, acc ->
      edge =
        String.split(nodes, "-")
        |> Enum.map(fn
          "start" ->
            @start

          "end" ->
            @end_

          index ->
            String.to_charlist(index)
            # Assuming unique first chars, not applicable for Big Boys
            |> Enum.at(0)
            # Make the n-th prime, negative = not_small letter
            |> then(fn n ->
              Enum.at(@primes, rem(n, length(@primes))) *
                if n >= 97, do: -1, else: 1
            end)
        end)

      case edge do
        # 'end' should have 0 connections
        [@end_, b] ->
          acc |> Map.update(b, [@end_], &[@end_ | &1])

        [a, @end_] ->
          acc |> Map.update(a, [@end_], &[@end_ | &1])

        # Do not point back to 'start'
        [@start, b] ->
          acc |> Map.update(@start, [b], &[b | &1])

        [a, @start] ->
          acc |> Map.update(@start, [a], &[a | &1])

        [a, b] ->
          acc
          |> Map.update(a, [b], &[b | &1])
          |> Map.update(b, [a], &[a | &1])
      end
    end)
  end

  defp store_connections(connections) do
    ets_pid = :ets.new(:state_store, [:set, :public])
    :ets.insert(ets_pid, {:connections, connections})
    ets_pid
  end

  defp connections(ets_pid, cave) do
    [connections: connections] = :ets.lookup(ets_pid, :connections)
    Map.get(connections, cave)
  end

  def part1(args) do
    connections = prepare_input(args)
    ets_pid = store_connections(connections)
    find_all_paths(@start, ets_pid, false, 1)
  end

  def part2(args) do
    connections = prepare_input(args)
    ets_pid = store_connections(connections)
    find_all_paths(@start, ets_pid, true, 1)
  end

  defmemo(find_all_paths(@end_, _, _, _), do: 1)

  defmemo find_all_paths(cave, ets_pid, can_revisit, path) when cave > 0 do
    connections(ets_pid, cave)
    |> Enum.reduce(0, fn connected_cave, acc ->
      acc + find_all_paths(connected_cave, ets_pid, can_revisit, path)
    end)
  end

  defmemo find_all_paths(cave, ets_pid, can_revisit, path) do
    in_path? = rem(path, cave) == 0

    cond do
      in_path? and !can_revisit ->
        0

      !in_path? ->
        connections(ets_pid, cave)
        |> Enum.reduce(0, fn connected_cave, acc ->
          acc + find_all_paths(connected_cave, ets_pid, can_revisit, cave * path)
        end)

      true ->
        connections(ets_pid, cave)
        |> Enum.reduce(0, fn connected_cave, acc ->
          acc + find_all_paths(connected_cave, ets_pid, false, cave * path)
        end)
    end
  end
end
