defmodule AdventOfCode.Y2016.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day01

  test "part1" do
    input = AdventOfCode.Input.get!(1, 2016)
    result = part1(input)

    assert result == 252
  end

  test "part2" do
    input = AdventOfCode.Input.get!(1, 2016)
    result = part2(input)

    assert result == 143
  end
end
