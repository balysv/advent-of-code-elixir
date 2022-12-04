defmodule AdventOfCode.Y2022.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day03

  test "part1" do
    input = AdventOfCode.Input.get!(3, 2022)
    result = part1(input)

    assert result == 8349
  end

  test "part2" do
    input = AdventOfCode.Input.get!(3, 2022)
    result = part2(input)

    assert result == 2681
  end
end
