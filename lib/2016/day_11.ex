defmodule AdventOfCode.Y2016.Day11 do
  use Memoize

  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(["contains a ", ", a ", " and a ", ", and a ", "."], trim: true)
      |> Enum.slice(1..-1)
      |> Enum.map(fn str ->
        str |> String.split(" ") |> Enum.map(&String.slice(&1, 0..1)) |> List.to_tuple()
      end)
    end)
  end

  def part1(args) do
    floors = args |> prepare_input()
    recur(neighbours({floors, 0}), [], [], 0)
  end

  def part2(args) do
    floors =
      args
      |> prepare_input()
      |> List.update_at(0, fn floor ->
        floor ++ [{"el", "ge"}, {"el", "mi"}, {"di", "ge"}, {"di", "mi"}]
      end)

    recur(neighbours({floors, 0}), [], [], 0)
  end

  defp recur([{[[], [], [], _], _} | _], _, visited, steps), do: steps + 1

  defp recur([], neighbours, visited, steps) do
    IO.inspect("layer #{steps}")
    recur(neighbours, [], visited, steps + 1)
  end

  defp recur([curr | rest], neighbours, visited, steps) do
    cond do
      normalize(curr) in visited ->
        recur(rest, neighbours, visited, steps)

      true ->
        new_neigbours = for state <- neighbours(curr), normalize(state) not in visited, do: state
        recur(rest, neighbours ++ new_neigbours, [normalize(curr) | visited], steps)
    end
  end

  defp neighbours({[f1, f2, f3, f4], 0}) do
    src_combinations(f1)
    |> Enum.map(fn items -> {[f1 -- items, f2 ++ items, f3, f4], 1} end)
    |> Enum.filter(fn {floors, _} -> Enum.all?(floors, &valid_state?/1) end)
    |> Enum.sort_by(fn {floors, _} -> rank(floors) end, :asc)
  end

  defp neighbours({[f1, f2, f3, f4], 3}) do
    src_combinations(f4)
    |> Enum.map(fn items -> {[f1, f2, f3 ++ items, f4 -- items], 2} end)
    |> Enum.filter(fn {floors, _} -> Enum.all?(floors, &valid_state?/1) end)
    |> Enum.sort_by(fn {floors, _} -> rank(floors) end, :asc)
  end

  defp neighbours({floors = [f1, f2, f3, f4], idx}) do
    floor = Enum.at(floors, idx)
    {dst1, dst2} = {Enum.at(floors, idx - 1), Enum.at(floors, idx + 1)}

    src_combinations(floor)
    |> Enum.flat_map(fn items ->
      r = [
        {floors
         |> List.replace_at(idx, floor -- items)
         |> List.replace_at(idx + 1, dst2 ++ items), idx + 1}
      ]

      if (idx == 1 and length(f1) == 0) or
           (idx == 2 and length(f1) == 0 and length(f2) == 0) do
        r
      else
        [
          {floors
           |> List.replace_at(idx, floor -- items)
           |> List.replace_at(idx - 1, dst1 ++ items), idx - 1}
          | r
        ]
      end
    end)
    |> Enum.filter(fn {floors, _} -> Enum.all?(floors, &valid_state?/1) end)
    |> Enum.sort_by(fn {floors, _} -> rank(floors) end, :asc)
  end

  defp rank([f1, f2, f3, f4]) do
    length(f1) * 3 + length(f2) * 2 + length(f3)
  end

  defp src_combinations(floor) do
    pairs =
      for {a, idx1} <- Enum.with_index(floor),
          {b, idx2} <- Enum.with_index(floor),
          idx1 > idx2,
          do: [a, b]

    Enum.map(floor, &List.wrap/1) ++ pairs
  end

  defp normalize({floors, elevator}) do
    {
      floors
      |> Enum.with_index()
      |> Enum.map(fn {floor, idx} ->
        floor
        |> Enum.sort()
        |> Enum.reduce({%{}, []}, fn {k, v}, {map, acc} ->
          hash = Map.get(map, k, "#{length(acc)}")
          {Map.put(map, k, hash), [hash <> v | acc]}
        end)
        |> elem(1)
        |> Enum.sort()
      end),
      elevator
    }
  end

  defp valid_state?(floor) do
    floor
    |> Enum.filter(&match?({_, "mi"}, &1))
    |> Enum.all?(fn
      {k, _} ->
        Enum.any?(floor, &match?({^k, "ge"}, &1)) or !Enum.any?(floor, &match?({_, "ge"}, &1))
    end)
  end
end
