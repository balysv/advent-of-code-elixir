defmodule AdventOfCode.Y2021.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day12_2

  test "part1" do
    input = AdventOfCode.Input.get!(12, 2021)
    result = part1(input)

    assert result == 4011
  end

  @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(12, 2021)
    result = part2(input)

    assert result == 108_035
  end

  @tag :skip
  test "bench" do
    input = AdventOfCode.Input.get!(12, 2021)

    Benchee.run(%{
      "p1_parse" => fn -> prepare_input(input) end,
      "p2_parse" => fn -> prepare_input(input) end,
      "p1_full" => fn -> part1(input) end,
      "p2_full" => fn -> part2(input) end
    })
  end

  @tag :skip
  @tag timeout: :infinity
  test "big boy 1" do
    input = """
    p-E
    f-C
    H-end
    G-k
    b-r
    a-G
    A-h
    end-B
    b-end
    j-m
    q-end
    o-H
    A-p
    D-n
    A-e
    m-G
    l-k
    l-A
    r-G
    j-l
    A-o
    p-k
    h-D
    d-E
    q-a
    f-g
    o-k
    g-G
    c-start
    start-end
    p-q
    D-d
    f-c
    e-a
    e-H
    h-k
    A-i
    j-c
    d-c
    q-G
    start-J
    o-J
    h-H
    b-f
    h-c
    j-C
    o-end
    i-g
    g-I
    G-c
    i-C
    e-c
    n-H
    a-C
    """

    Benchee.run(%{
      "big_boy_p1" => fn -> part1(input) end,
      "big_boy_p2" => fn -> part2(input) end
    })
  end
end
