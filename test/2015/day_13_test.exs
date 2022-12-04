defmodule AdventOfCode.Y2015.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day13

  test "part1" do
    input = AdventOfCode.Input.get!(13, 2015)
    result = part1(input)

    assert result == 733
  end

  test "part2" do
    input = AdventOfCode.Input.get!(13, 2015)
    result = part2(input)

    assert result == 725
  end
end
