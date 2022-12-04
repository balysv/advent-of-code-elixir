defmodule AdventOfCode.Y2017.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Y2017.Day06

  test "part1" do
    input = AdventOfCode.Input.get!(6, 2017)
    result = part1(input)

    assert result == 6681
  end

  test "part2" do
    input = AdventOfCode.Input.get!(6, 2017)
    result = part2(input)

    assert result == 1
  end
end
