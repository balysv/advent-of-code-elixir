defmodule AdventOfCode.Y2021.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day16

  test "part1" do
    # input = "A0016C880162017C3686B18A3D4780"
    input = AdventOfCode.Input.get!(16, 2021)
    result = part1(input)

    assert result == 895
  end

  test "part2" do
    # input = "F600BC2D8F"
    input = AdventOfCode.Input.get!(16, 2021)
    result = part2(input)

    assert result == 1_148_595_959_144
  end
end
