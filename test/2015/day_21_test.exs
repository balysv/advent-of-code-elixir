defmodule AdventOfCode.Y2015.Day21Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day21

  @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(21, 2015)
    result = part1(input)

    assert result == 1
  end

  @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(21, 2015)
    result = part2(input)

    assert result == 1
  end
end
