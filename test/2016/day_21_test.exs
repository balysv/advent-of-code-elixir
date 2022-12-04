defmodule AdventOfCode.Y2016.Day21Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day21

  test "part1" do
    input = AdventOfCode.Input.get!(21, 2016)
    result = part1(input)

    assert result == "gfdhebac"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(21, 2016)
    result = part2(input)

    assert result == "dhaegfbc"
  end
end
