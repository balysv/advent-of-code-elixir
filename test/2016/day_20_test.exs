defmodule AdventOfCode.Y2016.Day20Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day20

  test "part1" do
    input = AdventOfCode.Input.get!(20, 2016)
    result = part1(input)

    assert result == 14_975_795
  end

  test "part2" do
    input = AdventOfCode.Input.get!(20, 2016)
    result = part2(input)

    assert result == 1
  end
end
