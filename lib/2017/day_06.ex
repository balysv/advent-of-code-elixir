defmodule AdventOfCode.Y2017.Day06 do
  defp prepare_input(raw) do
    raw
    |> String.split(["\t", "\n", " "], trim: true)
    |> Enum.with_index()
    |> Map.new(fn {v, idx} -> {idx, String.to_integer(v)} end)
  end

  def part1(args) do
    banks = prepare_input(args)
    seen = MapSet.new([Map.values(banks)])
    bank_count = map_size(banks)

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while({banks, seen}, fn i, {banks, seen} ->
      {idx, blocks} = Enum.max_by(banks, &elem(&1, 1))

      banks =
        Enum.reduce((idx + 1)..(idx + blocks), banks, fn
          j, banks -> Map.update!(banks, rem(j, bank_count), &(&1 + 1))
        end)

      banks = Map.update!(banks, idx, &(&1 - blocks))
      values = Map.values(banks)

      if MapSet.member?(seen, values) do
        {:halt, i}
      else
        seen = MapSet.put(seen, Map.values(banks))
        {:cont, {banks, seen}}
      end
    end)
  end

  def part2(args) do
    banks = prepare_input(args)
    seen = %{Map.values(banks) => 0}
    bank_count = map_size(banks)

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while({banks, seen}, fn i, {banks, seen} ->
      {idx, blocks} = Enum.max_by(banks, &elem(&1, 1))

      banks =
        Enum.reduce((idx + 1)..(idx + blocks), banks, fn
          j, banks -> Map.update!(banks, rem(j, bank_count), &(&1 + 1))
        end)

      banks = Map.update!(banks, idx, &(&1 - blocks))
      values = Map.values(banks)

      if is_map_key(seen, values) do
        seen_at = Map.get(seen, values)
        {:halt, i - seen_at}
      else
        seen = Map.put(seen, values, i)
        {:cont, {banks, seen}}
      end
    end)
  end
end
