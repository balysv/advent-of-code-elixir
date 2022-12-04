defmodule AdventOfCode.Y2021.Day18Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day18

  test "part1" do
    input = AdventOfCode.Input.get!(18, 2021)
    result = part1(input)

    assert result == 3806
  end

  test "part2" do
    input = AdventOfCode.Input.get!(18, 2021)
    result = part2(input)

    assert result == 4727
  end
end
