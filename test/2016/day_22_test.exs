defmodule AdventOfCode.Y2016.Day22Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day22

  test "part1" do
    input = AdventOfCode.Input.get!(22, 2016)
    result = part1(input)

    assert result == 1020
  end

  test "part2" do
    input = AdventOfCode.Input.get!(22, 2016)
    result = part2(input)

    assert result == 198
  end
end
