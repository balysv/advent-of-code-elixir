defmodule AdventOfCode.Y2016.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day06

  test "part1" do
    input = AdventOfCode.Input.get!(6, 2016)
    result = part1(input)

    assert result == "qtbjqiuq"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(6, 2016)
    result = part2(input)

    assert result == "akothqli"
  end
end
