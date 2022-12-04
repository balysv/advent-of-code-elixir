defmodule AdventOfCode.Y2016.Day20 do
  defp prepare_input(raw) do
    raw
    |> String.split(["\n", "-"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.sort()
  end

  def part1(args),
    do:
      args
      |> prepare_input()
      |> blacklists()
      |> hd()
      |> Enum.at(1)
      |> then(&(&1 + 1))

  def part2(args),
    do:
      args
      |> prepare_input()
      |> blacklists()
      |> Enum.chunk_every(2, 1)
      |> Enum.reduce(0, fn
        [[_, e]], acc -> acc + max(4_294_967_295 - e - 1, 0)
        [[_, e], [s, _]], acc -> acc + s - e - 1
      end)

  defp blacklists(input) do
    input
    |> Enum.reduce([], fn
      range, _ = [] ->
        [range]

      range = [s, e], acc = [[ts, te] | rest] ->
        if te + 1 >= s do
          [[ts, max(e, te)] | rest]
        else
          [range | acc]
        end
    end)
    |> Enum.reverse()
  end
end
