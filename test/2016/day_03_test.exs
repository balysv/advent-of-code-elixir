defmodule AdventOfCode.Y2016.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day03

  test "part1" do
    input = AdventOfCode.Input.get!(3, 2016)
    result = part1(input)

    assert result == 983
  end

  test "part2" do
    input = AdventOfCode.Input.get!(3, 2016)
    result = part2(input)

    assert result == 1836
  end
end
