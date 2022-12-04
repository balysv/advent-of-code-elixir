defmodule AdventOfCode.Y2016.Day16 do
  def part1(args), do: args |> String.trim() |> solve(272)

  def part2(args), do: args |> String.trim() |> solve(35_651_584)

  defp solve(input, disk_size) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(input, fn
      _, str when byte_size(str) < disk_size -> {:cont, dragon_curve(str)}
      _, str -> {:halt, str}
    end)
    |> String.slice(0..(disk_size - 1))
    |> checksum()
  end

  defp dragon_curve(input) do
    b =
      input
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.map(fn
        "0" -> "1"
        "1" -> "0"
      end)
      |> Enum.join()

    input <> "0" <> b
  end

  defp checksum(data) do
    data
    |> String.graphemes()
    |> Stream.chunk_every(2)
    |> Stream.map(fn
      [f, f] -> "1"
      _ -> "0"
    end)
    |> Enum.join()
    |> then(fn
      cs when rem(byte_size(cs), 2) == 0 -> checksum(cs)
      cs -> cs
    end)
  end
end
