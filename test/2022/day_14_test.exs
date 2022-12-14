defmodule AdventOfCode.Y2022.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day14

  test "part1" do
    input = AdventOfCode.Input.get!(14, 2022)
    result = part1(input)

    assert result == 625
  end

  test "part2" do
    input = AdventOfCode.Input.get!(14, 2022)
    result = part2(input)

    assert result == 25193
  end
end
