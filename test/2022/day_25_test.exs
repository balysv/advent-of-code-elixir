defmodule AdventOfCode.Y2022.Day25Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day25

  test "part1" do
    input = AdventOfCode.Input.get!(25, 2022)
    result = part1(input)

    assert result == "20=2-02-0---02=22=21"
  end
end
