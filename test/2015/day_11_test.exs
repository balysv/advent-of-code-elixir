defmodule AdventOfCode.Y2015.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day11

  test "part1" do
    input = "hepxcrrq"
    result = part1(input)

    assert result == ~c"hepxxyzz"
  end

  test "part2" do
    input = "hepxxyzz"
    result = part2(input)

    assert result == ~c"heqaabcc"
  end
end
