defmodule AdventOfCode.Y2022.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day01

  test "part1" do
    input = AdventOfCode.Input.get!(1, 2022)
    result = part1(input)

    assert result == 67658
  end

  test "part2" do
    input = AdventOfCode.Input.get!(1, 2022)
    result = part2(input)

    assert result == 200158
  end
end
