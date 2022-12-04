defmodule AdventOfCode.Y2021.Day10 do
  @open_chars [?(, ?[, ?{, ?<]

  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  defp solve(line) do
    Enum.reduce_while(line, [], fn
      char, stack when char in @open_chars -> {:cont, [char | stack]}
      ?), [?( | stack] -> {:cont, stack}
      ?], [?[ | stack] -> {:cont, stack}
      ?}, [?{ | stack] -> {:cont, stack}
      ?>, [?< | stack] -> {:cont, stack}
      char, _ -> {:halt, char}
    end)
  end

  def part1(args) do
    prepare_input(args)
    |> Enum.map(&solve/1)
    |> Enum.filter(&is_integer/1)
    |> Enum.map(fn
      ?) -> 3
      ?] -> 57
      ?} -> 1197
      ?> -> 25137
    end)
    |> Enum.sum()
  end

  def part2(args) do
    prepare_input(args)
    |> Enum.map(&solve/1)
    |> Enum.filter(&is_list/1)
    |> Enum.map(
      &Enum.reduce(&1, 0, fn
        ?(, acc -> acc * 5 + 1
        ?[, acc -> acc * 5 + 2
        ?{, acc -> acc * 5 + 3
        ?<, acc -> acc * 5 + 4
      end)
    )
    |> Enum.sort()
    |> then(&Enum.at(&1, length(&1) |> div(2)))
  end
end
