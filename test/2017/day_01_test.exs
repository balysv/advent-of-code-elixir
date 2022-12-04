defmodule AdventOfCode.Y2017.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2017.Day01

  test "part1" do
    input = AdventOfCode.Input.get!(1, 2017)
    result = part1(input)

    assert result == 995
  end

  test "part2" do
    input = AdventOfCode.Input.get!(1, 2017)
    result = part2(input)

    assert result == 1
  end
end
