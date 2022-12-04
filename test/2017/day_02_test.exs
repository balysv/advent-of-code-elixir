defmodule AdventOfCode.Y2017.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Y2017.Day02

  test "part1" do
    input = AdventOfCode.Input.get!(2, 2017)
    result = part1(input)

    assert result == 47623
  end

  test "part2" do
    input = AdventOfCode.Input.get!(2, 2017)
    result = part2(input)

    assert result == 1
  end
end
