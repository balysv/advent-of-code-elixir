defmodule AdventOfCode.Y2016.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day02

  test "part1" do
    input = AdventOfCode.Input.get!(2, 2016)
    result = part1(input)

    assert result == "97289"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(2, 2016)
    result = part2(input)

    assert result == "9A7DC"
  end
end
