defmodule AdventOfCode.Y2015.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day10

  test "part1" do
    input = "1113222113"
    result = part1(input)

    assert result == 252594
  end

  test "part2" do
    input = "1113222113"
    result = part2(input)

    assert result == 3579328
  end
end
