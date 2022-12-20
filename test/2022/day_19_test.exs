defmodule AdventOfCode.Y2022.Day19Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day19

  @tag :skip
  @tag timeout: :infinity
  test "part1" do
    input = AdventOfCode.Input.get!(19, 2022)

    result = part1(input)

    assert result == 960
  end

  @tag :skip
  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(19, 2022)
    result = part2(input)

    assert result == 2040
  end
end
