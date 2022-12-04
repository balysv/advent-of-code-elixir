defmodule AdventOfCode.Y2015.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day15

  test "part1" do
    input = AdventOfCode.Input.get!(15, 2015)
    result = part1(input)

    assert result == 21367368
  end

  test "part2" do
    input = AdventOfCode.Input.get!(15, 2015)
    result = part2(input)

    assert result == 1766400
  end
end
