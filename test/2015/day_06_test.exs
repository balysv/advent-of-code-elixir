defmodule AdventOfCode.Y2015.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day06

  @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(6, 2015)
    result = part1(input)

    assert result == 377_891
  end

  @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(6, 2015)
    result = part2(input)

    assert result == 377_891
  end
end
