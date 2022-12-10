defmodule AdventOfCode.Y2022.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day10

  test "part1" do
    input = AdventOfCode.Input.get!(10, 2022)
    result = part1(input)

    assert result == 12560
  end

  test "part2" do
    input = AdventOfCode.Input.get!(10, 2022)
    result = part2(input)

    assert result == :ok
  end
end
