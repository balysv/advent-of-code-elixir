defmodule AdventOfCode.Y2022.Day17Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day17

  @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(17, 2022)
    result = part1(input)

    assert result == 3124
  end

  @tag :skip
  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(17, 2022)
    result = part2(input)

    assert result == 1_561_176_470_569
  end
end
