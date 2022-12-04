defmodule AdventOfCode.Y2016.Day09 do
  def part1(args), do: args |> String.trim() |> process_p1(0)

  defp process_p1("", acc), do: acc

  defp process_p1(<<"(", rest::binary>>, acc) do
    [marker, rest] = String.split(rest, ")", parts: 2)
    [len, times] = marker |> String.split("x") |> Enum.map(&String.to_integer/1)
    {captured, rest} = String.split_at(rest, len)
    process_p1(rest, String.length(captured) * times + acc)
  end

  defp process_p1(<<_::bytes-size(1)>> <> rest, acc), do: process_p1(rest, acc + 1)

  def part2(args), do: args |> String.trim() |> process_p2(0)

  defp process_p2("", acc), do: acc

  defp process_p2(<<"(", rest::binary>>, acc) do
    {{captured, rest}, times} = process_group(rest)
    acc = acc + process_p2(captured, 0) * times
    process_p2(rest, acc)
  end

  defp process_p2(<<_::bytes-size(1)>> <> rest, acc), do: process_p2(rest, acc + 1)

  defp process_group(string) do
    [marker, rest] = String.split(string, ")", parts: 2)
    [len, times] = marker |> String.split("x") |> Enum.map(&String.to_integer/1)
    {String.split_at(rest, len), times}
  end
end
