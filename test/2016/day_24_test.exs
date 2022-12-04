defmodule AdventOfCode.Y2016.Day24Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day24

  test "part1" do
    input = AdventOfCode.Input.get!(24, 2016)

    result = part1(input)

    assert result == 412
  end

  test "part2" do
    input = AdventOfCode.Input.get!(24, 2016)
    result = part2(input)

    assert result == 664
  end
end
