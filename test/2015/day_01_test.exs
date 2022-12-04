defmodule AdventOfCode.Y2015.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day01

  test "part1" do
    input = AdventOfCode.Input.get!(1, 2015)
    result = part1(input)

    assert result == 280
  end

  test "part2" do
    input = AdventOfCode.Input.get!(1, 2015)
    result = part2(input)

    assert result == 1797
  end
end
