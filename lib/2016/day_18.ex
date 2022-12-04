defmodule AdventOfCode.Y2016.Day18 do
  def part1(args), do: args |> String.trim() |> compute(40)

  def part2(args), do: args |> String.trim() |> compute(400_000)

  defp compute(input, count) do
    1..count
    |> Enum.reduce({input, 0}, fn
      _, {str, count} -> {next_line(str), count + count_safe(str)}
    end)
    |> elem(1)
  end

  defp next_line(str) do
    str
    |> pad()
    |> String.graphemes()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn
      ["^", "^", "."] -> "^"
      [".", "^", "^"] -> "^"
      ["^", ".", "."] -> "^"
      [".", ".", "^"] -> "^"
      _ -> "."
    end)
    |> Enum.join()
  end

  defp count_safe(str), do: str |> String.graphemes() |> Enum.frequencies() |> Map.get(".")

  defp pad(str), do: "." <> str <> "."
end
