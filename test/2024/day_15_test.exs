defmodule AdventOfCode.Y2024.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day15

  test "part1" do
    input = AdventOfCode.Input.get!(15, 2024)
    result = part1(input)
    # A few shots as some clarification of how the robot
    # moved was needed
    assert result == 1_437_174
  end

  test "part2" do
    input = AdventOfCode.Input.get!(15, 2024)
    result = part2(input)
    # Did not manage to complete without large interventions
    assert result == 1_437_468
  end
end
