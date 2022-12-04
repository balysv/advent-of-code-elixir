defmodule AdventOfCode.Y2021.Day24Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day24

  @tag :skip
  @tag timeout: :infinity
  test "part1" do
    input = AdventOfCode.Input.get!(24, 2021)
    result = part1(input)

    assert result == 1
  end

  @tag :skip
  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(24, 2021)
    result = part2(input)

    assert result == 1
  end
end
