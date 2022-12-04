defmodule AdventOfCode.Y2016.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day16

  @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(16, 2016)
    result = part1(input)

    assert result == "11100110111101110"
  end

  @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(16, 2016)
    result = part2(input)

    assert result == "10001101010000101"
  end
end
