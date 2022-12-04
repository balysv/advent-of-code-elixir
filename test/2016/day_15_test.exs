defmodule AdventOfCode.Y2016.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day15

  test "part1" do
    input = AdventOfCode.Input.get!(15, 2016)
    result = part1(input)

    assert result == 376777
  end

  test "part2" do
    input = AdventOfCode.Input.get!(15, 2016)
    result = part2(input)

    assert result == 3903937
  end
end
