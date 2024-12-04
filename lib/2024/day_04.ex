defmodule AdventOfCode.Y2024.Day04 do
  defp parse_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp get_grid_dimensions(grid) do
    {length(grid), length(hd(grid))}
  end

  defp get_char_at(grid, {y, x}) do
    Enum.at(Enum.at(grid, y), x)
  end

  defp in_bounds?(grid, {y, x}) do
    {height, width} = get_grid_dimensions(grid)
    y >= 0 and y < height and x >= 0 and x < width
  end

  defp get_chars_at_positions(grid, positions) do
    positions
    |> Enum.map(fn pos ->
      if in_bounds?(grid, pos), do: get_char_at(grid, pos)
    end)
    |> Enum.reject(&is_nil/1)
  end

  @doc """
  --- Day 4: Ceres Search ---

  "Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

  As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

  This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:

  ..X...
  .SAMX.
  .A..A.
  XMAS.S
  .X....

  The actual word search will be full of letters instead. For example:

  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX

  In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where letters not involved in any XMAS have been replaced with .:

  ....XXMAS.
  .SAMXMS...
  ...S..A...
  ..A.A.MS.X
  XMASAMX.MM
  X.....XA.A
  S.S.S.S.SS
  .A.A.A.A.A
  ..M.M.M.MM
  .X.X.XMASX

  Take a look at the little Elf's word search. How many times does XMAS appear?

  """
  def part1(args) do
    grid = parse_input(args)
    {height, width} = get_grid_dimensions(grid)

    directions = [
      {0, 1},
      {1, 1},
      {1, 0},
      {1, -1},
      {0, -1},
      {-1, -1},
      {-1, 0},
      {-1, 1}
    ]

    for row <- 0..(height - 1),
        col <- 0..(width - 1),
        direction <- directions,
        check_pattern?(grid, {row, col}, direction, "XMAS"),
        reduce: 0 do
      count -> count + 1
    end
  end

  defp check_pattern?(grid, {row, col}, {dy, dx}, pattern) do
    positions =
      0..(String.length(pattern) - 1)
      |> Enum.map(fn i -> {row + dy * i, col + dx * i} end)

    chars = get_chars_at_positions(grid, positions)
    Enum.join(chars) == pattern
  end

  @doc """
  --- Part Two ---

  The Elf looks quizzically at you. Did you misunderstand the assignment?

  Looking for the instructions, you flip over the word search to find that this isn't actually an XMAS puzzle; it's an X-MAS puzzle in which you're supposed to find two MAS in the shape of an X. One way to achieve that is like this:

  M.S
  .A.
  M.S

  Irrelevant characters have again been replaced with . in the above diagram. Within the X, each MAS can be written forwards or backwards.

  Here's the same example from before, but this time all of the X-MASes have been kept instead:

  .M.S......
  ..A..MSMS.
  .M.S.MAA..
  ..A.ASMSM.
  .M.S.M....
  ..........
  S.S.S.S.S.
  .A.A.A.A..
  M.M.M.M.M.
  ..........

  In this example, an X-MAS appears 9 times.

  Flip the word search from the instructions back over to the word search side and try again. How many times does an X-MAS appear?

  """
  def part2(args) do
    grid = parse_input(args)
    {height, width} = get_grid_dimensions(grid)

    for row <- 1..(height - 2),
        col <- 1..(width - 2),
        check_x_pattern?(grid, {row, col}),
        reduce: 0 do
      count -> count + 1
    end
  end

  defp check_x_pattern?(grid, {row, col}) do
    diagonals = [
      # top-left to bottom-right
      [{-1, -1}, {0, 0}, {1, 1}],
      # top-right to bottom-left
      [{-1, 1}, {0, 0}, {1, -1}]
    ]

    diagonals
    |> Enum.map(fn direction_set ->
      positions =
        Enum.map(direction_set, fn {dy, dx} ->
          {row + dy, col + dx}
        end)

      get_chars_at_positions(grid, positions) |> Enum.join()
    end)
    |> Enum.all?(fn chars -> chars in ["MAS", "SAM"] end)
  end
end
