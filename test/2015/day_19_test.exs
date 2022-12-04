defmodule AdventOfCode.Y2015.Day19Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day19

  test "part1" do
    input = AdventOfCode.Input.get!(19, 2015)
    result = part1(input)

    assert result == 535
  end

  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(19, 2015)
    result = part2(input)

    assert result == 212
  end
end
