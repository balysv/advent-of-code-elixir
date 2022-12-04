defmodule AdventOfCode.Y2016.Day25Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day25

  test "part1" do
    input = AdventOfCode.Input.get!(25, 2016)
    result = part1(input)

    assert result == 182
  end
end
