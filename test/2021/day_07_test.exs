defmodule AdventOfCode.Y2021.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day07

  test "part1" do
    input = "16,1,2,0,4,2,7,1,2,14"
    # input = AdventOfCode.Input.get!(7, 2021)
    result = part1(input)

    assert result == 37
  end

  test "part2" do
    input = "16,1,2,0,4,2,7,1,2,14"
    # input = AdventOfCode.Input.get!(7, 2021)
    result = part2(input)

    assert result == 168
  end

  @tag :skip
  @tag timeout: :infinity
  test "big_boy" do
    {:ok, input} = File.read("test/advent_of_code/day_07_big_boy.in")

    Benchee.run(%{
      "big_boy" => fn -> big_boy(input) end,
      "big_boy_parallel" => fn -> big_boy_parallel(input) end,
      "big_boy_parallel_2" => fn -> big_boy_parallel_2(input) end
    })
  end
end
