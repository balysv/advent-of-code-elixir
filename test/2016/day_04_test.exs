defmodule AdventOfCode.Y2016.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day04

  test "part1" do
    input = AdventOfCode.Input.get!(4, 2016)
    result = part1(input)

    assert result == 158_835
  end

  test "part2" do
    input = AdventOfCode.Input.get!(4, 2016)
    result = part2(input)

    assert result == 993
  end
end
