defmodule AdventOfCode.Y2024.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day02

  test "part1" do
    input = AdventOfCode.Input.get!(2, 2024)
    result = part1(input)
    # 2-shot solution
    assert result == 483
  end

  test "part2" do
    input = AdventOfCode.Input.get!(2, 2024)
    result = part2(input)
    # 1-shot solution
    assert result == 528
  end
end
