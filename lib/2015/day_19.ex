defmodule AdventOfCode.Y2015.Day19 do
  def part1(args) do
    [mapping, code] = args |> String.split("\n\n", trim: true)

    mapping =
      mapping
      |> String.split(["\n", " => "])
      |> Enum.chunk_every(2)
      |> Enum.map(&List.to_tuple/1)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
      |> Enum.into(%{})

    letters = code |> String.replace("\n", "") |> String.graphemes()

    o1 =
      letters
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn {l, idx}, acc ->
        if Map.has_key?(mapping, l) do
          new =
            Map.get(mapping, l)
            |> Enum.map(fn s -> List.replace_at(letters, idx, s) end)
            |> Enum.map(&Enum.join/1)
            |> Enum.into(MapSet.new())

          MapSet.union(new, acc)
        else
          acc
        end
      end)

    o2 =
      letters
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn {ls, idx}, acc ->
        l = Enum.join(ls)

        if Map.has_key?(mapping, l) do
          new =
            Map.get(mapping, l)
            |> Enum.map(fn s ->
              letters
              |> List.delete_at(idx + 1)
              |> List.replace_at(idx, s)
            end)
            |> Enum.map(&Enum.join/1)
            |> Enum.into(MapSet.new())

          MapSet.union(new, acc)
        else
          acc
        end
      end)

    MapSet.union(o1, o2) |> MapSet.size()
  end

  def part2(args) do
    [mapping, code] = args |> String.split("\n\n", trim: true)

    mapping =
      mapping
      |> String.split(["\n", " => "])
      |> Enum.chunk_every(2)
      |> Enum.map(fn [a, b] -> {b, a} end)
      |> Enum.sort_by(fn {k, _} -> byte_size(k) end, :desc)

    letters = code |> String.replace("\n", "")

    1..100
    |> Enum.map(fn _ -> run_simulation(letters, mapping) end)
    |> Enum.filter(&is_integer/1)
    |> Enum.min()
  end

  defp run_simulation(letters, mapping) do
    1..250
    |> Enum.reduce_while(letters, fn i, l ->
      if l == "e" do
        {:halt, i - 1}
      else
        valid = mapping |> Enum.filter(fn {k, _} -> String.contains?(l, k) end)

        if length(valid) == 0 do
          {:halt, :err}
        else
          {k, v} = Enum.random(valid)
          split = String.split(l, k)
          pos = :rand.uniform(max(1, length(split) - 1)) - 1

          r =
            split
            |> Enum.with_index()
            |> Enum.reduce("", fn {s, idx}, acc ->
              cond do
                idx == length(split) - 1 -> acc <> s
                idx == pos -> acc <> s <> v
                true -> acc <> s <> k
              end
            end)

          {:cont, r}
        end
      end
    end)
  end
end
