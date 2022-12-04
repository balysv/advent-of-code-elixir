defmodule AdventOfCode.Y2021.Day22Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day22

  test "part1" do
    input = AdventOfCode.Input.get!(22, 2021)
    result = part1(input)

    assert result == 647_076
  end

  test "part2" do
    input = AdventOfCode.Input.get!(22, 2021)
    result = part2(input)

    assert result == 1_233_304_599_156_793
  end
end
