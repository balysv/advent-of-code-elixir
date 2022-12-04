defmodule AdventOfCode.Y2015.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day16

  test "part1" do
    input = AdventOfCode.Input.get!(16, 2015)
    result = part1(input)

    assert result == 213
  end

  test "part2" do
    input = AdventOfCode.Input.get!(16, 2015)
    result = part2(input)

    assert result == 323
  end
end
