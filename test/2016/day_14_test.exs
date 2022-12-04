defmodule AdventOfCode.Y2016.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day14

  @tag :skip
  test "part1" do
    input = "ahsbgdzn"
    result = part1(input)

    assert result == 23890
  end

  @tag :skip
  @tag timeout: :infinity
  test "part2" do
    input = "ahsbgdzn"
    result = part2(input)

    assert result == 22696
  end
end
