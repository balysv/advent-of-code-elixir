defmodule AdventOfCode.Y2015.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day08

  test "part1" do
    input = AdventOfCode.Input.get!(8, 2015)
    result = part1(input)

    assert result == 1333
  end

  test "part2" do
    input = AdventOfCode.Input.get!(8, 2015)
    result = part2(input)

    assert result == 2046
  end
end
