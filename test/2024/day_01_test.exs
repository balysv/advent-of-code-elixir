defmodule AdventOfCode.Y2024.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day01

  test "part1" do
    input = AdventOfCode.Input.get!(1, 2024)
    result = part1(input)
    assert result == 2_769_675
  end

  test "part2" do
    input = AdventOfCode.Input.get!(1, 2024)
    result = part2(input)
    assert result == 24_643_097
  end
end
