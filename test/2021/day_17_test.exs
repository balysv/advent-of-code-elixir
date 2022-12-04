defmodule AdventOfCode.Y2021.Day17Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day17

  test "part1" do
    input = "target area: x=20..30, y=-10..-5"
    # input = AdventOfCode.Input.get!(17, 2021)
    result = part1(input)

    assert result == 45
  end

  test "part2" do
    input = "target area: x=20..30, y=-10..-5"
    # input = AdventOfCode.Input.get!(17, 2021)
    result = part2(input)

    assert result == 112
  end
end
