defmodule AdventOfCode.Y2016.Day15 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      ~r/Disc #\d+ has (\d+) positions; at time=0, it is at position (\d+)./
      |> Regex.run(line, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  def part1(args), do: args |> prepare_input() |> solve()

  def part2(args), do: args |> prepare_input() |> add_p2_disc() |> solve()

  defp add_p2_disc(discs), do: discs ++ [{11, 0}]

  defp solve(discs) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.find(fn t ->
      Enum.all?(Enum.with_index(discs), fn {{size, pos}, idx} ->
        rem(pos + t + idx + 1, size) == 0
      end)
    end)
  end
end
