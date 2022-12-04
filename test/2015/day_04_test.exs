defmodule AdventOfCode.Y2015.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day04

  @tag :skip
  test "part1" do
    input = "bgvyzdsv"
    result = part1(input)

    assert result == 254_575
  end

  @tag :skip
  test "part2" do
    input = "bgvyzdsv"
    result = part2(input)

    assert result == 1_038_736
  end
end
