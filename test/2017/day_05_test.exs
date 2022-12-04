defmodule AdventOfCode.Y2017.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Y2017.Day05

  test "part1" do
    input = AdventOfCode.Input.get!(5, 2017)
    result = part1(input)

    assert result == 343_467
  end

  test "part2" do
    input = AdventOfCode.Input.get!(5, 2017)
    result = part2(input)

    assert result == 1
  end
end
