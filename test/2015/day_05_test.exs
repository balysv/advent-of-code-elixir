defmodule AdventOfCode.Y2015.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day05

  test "part1" do
    input = AdventOfCode.Input.get!(5, 2015)
    result = part1(input)

    assert result == 258
  end

  test "part2" do
    input = AdventOfCode.Input.get!(5, 2015)
    result = part2(input)

    assert result == 53
  end
end
