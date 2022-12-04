defmodule AdventOfCode.Y2016.Day23Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day23

  @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(23, 2016)
    result = part1(input)

    assert result == 12654
  end

  @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(23, 2016)
    result = part2(input)

    assert result == 479_009_214
  end
end
