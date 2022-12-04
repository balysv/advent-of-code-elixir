defmodule AdventOfCode.Y2017.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Y2017.Day04

  test "part1" do
    input = AdventOfCode.Input.get!(4, 2017)
    result = part1(input)

    assert result == 325
  end

  test "part2" do
    input = AdventOfCode.Input.get!(4, 2017)
    result = part2(input)

    assert result == 119
  end
end
