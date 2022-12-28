defmodule AdventOfCode.Y2022.Day22Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day22

  test "part1" do
    input = AdventOfCode.Input.get!(22, 2022)

    result = part1(input)

    assert result == 55244
  end

  test "part2" do
    input = AdventOfCode.Input.get!(22, 2022)
    result = part2(input)

    assert result == 123_149
  end
end
