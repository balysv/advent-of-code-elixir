defmodule AdventOfCode.Y2024.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day10

  test "part1" do
    input = AdventOfCode.Input.get!(10, 2024)
    result = part1(input)
    # Many shots, the AI didn't understand the requirements
    # of computing the score of a trailhead.
    assert result == 659
  end

  test "part2" do
    input = AdventOfCode.Input.get!(10, 2024)
    result = part2(input)
    # Many shots as again the AI didn't understand the requirements
    # of computing the score of a trailhead.
    assert result == 1463
  end
end
