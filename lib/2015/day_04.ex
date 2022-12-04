defmodule AdventOfCode.Y2015.Day04 do
  def to_base2_string(binary) do
    for(<<x::size(1) <- binary>>, do: "#{x}")
    |> Enum.join("")
  end

  defp search(prefix, number, target) do
    r = :crypto.hash(:md5, prefix <> Integer.to_string(number)) |> Base.encode16()

    if String.starts_with?(r, target) do
      number
    else
      search(prefix, number + 1, target)
    end
  end

  def part1(args), do: search(args, 0, "00000")

  def part2(args), do: search(args, 0, "000000")
end
