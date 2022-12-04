defmodule AdventOfCode.Y2015.Day23Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day23

  test "part1" do
    input = AdventOfCode.Input.get!(23, 2015)
    result = part1(input)

    assert result == 307
  end

  test "part2" do
    input = AdventOfCode.Input.get!(23, 2015)
    result = part2(input)

    assert result == 160
  end
end
