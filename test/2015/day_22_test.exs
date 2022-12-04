defmodule AdventOfCode.Y2015.Day22Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day22

  test "part1" do
    input = {51, 9, []}
    result = part1(input)

    assert result == 900
  end

  test "part2" do
    input = {51, 9, []}
    result = part2(input)

    assert result == 1
  end
end
