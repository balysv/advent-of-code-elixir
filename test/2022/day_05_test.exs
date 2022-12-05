defmodule AdventOfCode.Y2022.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day05

  test "part1" do
    input = AdventOfCode.Input.get!(5, 2022)
    result = part1(input)

    assert result == "LJSVLTWQM"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(5, 2022)
    result = part2(input)

    assert result == "BRQWDBBJM"
  end
end
