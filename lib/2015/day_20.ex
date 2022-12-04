defmodule AdventOfCode.Y2015.Day20 do
  defmodule Factors do

    def of(1), do: [1]

    def of(n) do
      [n | factors(n, div(n, 2))]
    end

    defp factors(1, _), do: [1]
    defp factors(_, 1), do: [1]

    defp factors(n, i) do
      if rem(n, i) == 0 do
        [i | factors(n, i - 1)]
      else
        factors(n, i - 1)
      end
    end
  end

  def part1(args) do
    target = div(args, 10)
    700000..17000000
    |> Enum.find(fn house ->
      presents = Factors.of(house)
      |> Enum.sum()
      presents >= target
    end)
  end

  def part2(args) do
    target = args
    771120..target
    |> Enum.find(fn house ->
        presents = Factors.of(house)
        |> Enum.filter(fn factor -> factor * 50 >= house end)
        |> Enum.sum()
        presents * 11 >= target
      end)
  end
end
