defmodule AdventOfCode.Y2016.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day13

  test "part1" do
    result = part1()

    assert result == 86
  end

  @tag :skip
  test "part2" do
    result = part2()

    assert result == 127
  end
end
