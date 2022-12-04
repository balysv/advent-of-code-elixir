defmodule AdventOfCode.Y2015.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day14

  test "part1" do
    input = AdventOfCode.Input.get!(14, 2015)
    result = part1(input)

    assert result == {"Vixen", 2660}
  end

  test "part2" do
    input = AdventOfCode.Input.get!(14, 2015)
    result = part2(input)

    assert result == {"Blitzen", {2565, 1256}}
  end
end
