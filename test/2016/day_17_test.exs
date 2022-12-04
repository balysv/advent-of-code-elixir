defmodule AdventOfCode.Y2016.Day17Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day17

  test "part1" do
    input = AdventOfCode.Input.get!(17, 2016)
    result = part1(input)

    assert result == "DDRRULRDRD"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(17, 2016)
    result = part2(input)

    assert result == 536
  end
end
