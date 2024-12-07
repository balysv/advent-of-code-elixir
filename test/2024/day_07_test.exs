defmodule AdventOfCode.Y2024.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day07

  test "part1" do
    input = AdventOfCode.Input.get!(7, 2024)
    result = part1(input)
    # 1 shot
    assert result == 12_553_187_650_171
  end

  test "part2" do
    input = AdventOfCode.Input.get!(7, 2024)
    result = part2(input)
    # 1 shot
    assert result == 96_779_702_119_491
  end
end
