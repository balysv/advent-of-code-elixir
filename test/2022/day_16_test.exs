defmodule AdventOfCode.Y2022.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day16

  test "part1" do
    input = AdventOfCode.Input.get!(16, 2022)
    result = part1(input)

    assert result == 1906
  end

  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(16, 2022)
    result = part2(input)

    assert result == 2548
  end
end
