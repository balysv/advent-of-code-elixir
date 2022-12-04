defmodule AdventOfCode.Y2021.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day01

  test "part1" do
    input = "199
    200
    208
    210
    200
    207
    240
    269
    260
    263"
    # input = AdventOfCode.Input.get!(1, 2021)

    result = part1(input)

    assert result == 7
  end

  test "part2" do
    input = "199
    200
    208
    210
    200
    207
    240
    269
    260
    263"

    # input = AdventOfCode.Input.get!(1, 2021)
    result = part2(input)

    assert result == 5
  end
end
