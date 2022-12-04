defmodule AdventOfCode.Y2016.Day04 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_, name, sector_id, checksum] = Regex.run(~r/([a-z\-]+)([0-9]*)\[(.*)\]/, line)
      {name, String.to_integer(sector_id), checksum}
    end)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> real_rooms()
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> real_rooms()
    |> Enum.find(fn {name, sector_id, _} ->
      name
      |> String.to_charlist()
      |> Enum.map(fn
        ?- -> ?\s
        c -> rem(c - 97 + sector_id, 26) + 97
      end)
      |> List.starts_with?('north')
    end)
    |> elem(1)
  end

  defp real_rooms(input) do
    input
    |> Enum.filter(fn {name, _, checksum} ->
      to_check =
        name
        |> String.replace("-", "")
        |> String.graphemes()
        |> Enum.frequencies()
        |> Enum.group_by(&elem(&1, 1))
        |> Enum.sort(:desc)
        |> Enum.flat_map(fn {_, l} -> l end)
        |> Enum.map(&elem(&1, 0))
        |> Enum.take(5)
        |> Enum.join()

      checksum == to_check
    end)
  end
end
