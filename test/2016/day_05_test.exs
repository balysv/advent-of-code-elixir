defmodule AdventOfCode.Y2016.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day05

  @tag :skip
  test "part1" do
    input = "uqwqemis"
    result = part1(input)

    assert result == "1a3099aa"
  end

  @tag :skip
  @tag timeout: :infinity
  test "part2" do
    input = "uqwqemis"
    result = part2(input)

    assert result == "694190cd"
  end
end
