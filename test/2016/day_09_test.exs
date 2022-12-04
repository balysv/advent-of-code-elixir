defmodule AdventOfCode.Y2016.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day09

  test "part1" do
    input = AdventOfCode.Input.get!(9, 2016)
    result = part1(input)

    assert result == 99145
  end

  test "part2" do
    input = AdventOfCode.Input.get!(9, 2016)
    result = part2(input)

    assert result == 10_943_094_568
  end
end
