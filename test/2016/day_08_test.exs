defmodule AdventOfCode.Y2016.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day08

  test "part1" do
    input = AdventOfCode.Input.get!(8, 2016)
    result = part1(input)

    assert result == 128
  end

  test "part2" do
    input = AdventOfCode.Input.get!(8, 2016)
    result = part2(input)

    assert result
  end
end
