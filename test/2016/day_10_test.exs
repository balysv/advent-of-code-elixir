defmodule AdventOfCode.Y2016.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day10

  test "part1" do
    input = AdventOfCode.Input.get!(10, 2016)
    result = part1(input)

    assert result == "bot 98"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(10, 2016)
    result = part2(input)

    assert result == 4042
  end
end
