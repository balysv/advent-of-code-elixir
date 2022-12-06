defmodule AdventOfCode.Y2022.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day06

  test "part1" do
    input = AdventOfCode.Input.get!(6, 2022)
    result = part1(input)

    assert result == 1850
  end

  test "part2" do
    input = AdventOfCode.Input.get!(6, 2022)
    result = part2(input)

    assert result == 2823
  end
end
