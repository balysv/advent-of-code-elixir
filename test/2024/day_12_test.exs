defmodule AdventOfCode.Y2024.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day12

  @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(12, 2024)
    result = part1(input)
    # 5-6 shot to clarify some bits and debug the perimeter function
    assert result == 1_457_298
  end

  test "part2" do
    input = AdventOfCode.Input.get!(12, 2024)
    result = part2(input)
    # Dit not finish, with a lot of hinting and quite a bit of time
    # managed to hack an ugly solution that works
    assert result == 921_636
  end
end
