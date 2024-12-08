defmodule AdventOfCode.Y2024.Day08 do
  defp parse_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _x} -> char != "." end)
      |> Enum.map(fn {char, x} -> {char, {x, y}} end)
    end)
  end

  defp find_antinodes_part1({freq, pos1}, {freq, pos2}) do
    {x1, y1} = pos1
    {x2, y2} = pos2

    # Calculate vector between antennas
    dx = x2 - x1
    dy = y2 - y1

    # Apply vector outward from each node
    [
      # Move away from pos1 in opposite direction of pos2
      {x1 - dx, y1 - dy},
      # Move away from pos2 in direction away from pos1
      {x2 + dx, y2 + dy}
    ]
  end

  defp find_antinodes_part2({freq, pos1}, {freq, pos2}, max_x) do
    {x1, y1} = pos1
    {x2, y2} = pos2

    # Calculate vector between points
    dx = x2 - x1
    dy = y2 - y1

    # Find all points on the line (including antenna positions)
    for t <- -max_x..max_x do
      {x1 + t * dx, y1 + t * dy}
    end
  end

  defp in_bounds?({x, y}, max_x, max_y) do
    x >= 0 and y >= 0 and x <= max_x and y <= max_y
  end

  defp solve(args, find_antinodes_fn) do
    lines = String.split(args, "\n", trim: true)
    max_x = String.length(hd(lines)) - 1
    max_y = length(lines) - 1

    antennas = parse_input(args)
    freq_groups = Enum.group_by(antennas, &elem(&1, 0))

    antinodes =
      for {freq, positions} <- freq_groups,
          # Only process frequencies with multiple antennas
          length(positions) > 1,
          {_, pos1} <- positions,
          {_, pos2} <- positions,
          pos1 < pos2 do
        find_antinodes_fn.({freq, pos1}, {freq, pos2})
      end

    antinodes
    |> List.flatten()
    |> Enum.filter(&in_bounds?(&1, max_x, max_y))
    |> Enum.uniq()
    |> length()
  end

  @doc """
  --- Day 8: Resonant Collinearity ---

  You find yourselves on the roof of a top-secret Easter Bunny installation.

  While The Historians do their thing, you take a look at the familiar huge antenna. Much to your surprise, it seems to have been reconfigured to emit a signal that makes people 0.1% more likely to buy Easter Bunny brand Imitation Mediocre Chocolate as a Christmas gift! Unthinkable!

  Scanning across the city, you find that there are actually many such antennas. Each antenna is tuned to a specific frequency indicated by a single lowercase letter, uppercase letter, or digit. You create a map (your puzzle input) of these antennas. For example:

  ............
  ........0...
  .....0......
  .......0....
  ....0.......
  ......A.....
  ............
  ............
  ........A...
  .........A..
  ............
  ............

  The signal only applies its nefarious effect at specific antinodes based on the resonant frequencies of the antennas. In particular, an antinode occurs at any point that is perfectly in line with two antennas of the same frequency - but only when one of the antennas is twice as far away as the other. This means that for any pair of antennas with the same frequency, there are two antinodes, one on either side of them.

  So, for these two antennas with frequency a, they create the two antinodes marked with #:

  ..........
  ...#......
  ..........
  ....a.....
  ..........
  .....a....
  ..........
  ......#...
  ..........
  ..........

  Adding a third antenna with the same frequency creates several more antinodes. It would ideally add four antinodes, but two are off the right side of the map, so instead it adds only two:

  ..........
  ...#......
  #.........
  ....a.....
  ........a.
  .....a....
  ..#.......
  ......#...
  ..........
  ..........

  Antennas with different frequencies don't create antinodes; A and a count as different frequencies. However, antinodes can occur at locations that contain antennas. In this diagram, the lone antenna with frequency capital A creates no antinodes but has a lowercase-a-frequency antinode at its location:

  ..........
  ...#......
  #.........
  ....a.....
  ........a.
  .....a....
  ..#.......
  ......A...
  ..........
  ..........

  The first example has antennas with two different frequencies, so the antinodes they create look like this, plus an antinode overlapping the topmost A-frequency antenna:

  ......#....#
  ...#....0...
  ....#0....#.
  ..#....0....
  ....0....#..
  .#....A.....
  ...#........
  #......#....
  ........A...
  .........A..
  ..........#.
  ..........#.

  Because the topmost A-frequency antenna overlaps with a 0-frequency antinode, there are 14 total unique locations that contain an antinode within the bounds of the map.

  Calculate the impact of the signal. How many unique locations within the bounds of the map contain an antinode?

  """
  def part1(args) do
    solve(args, &find_antinodes_part1/2)
  end

  @doc """
    Watching over your shoulder as you work, one of The Historians asks if you took the effects of resonant harmonics into your calculations.

  Whoops!

  After updating your model, it turns out that an antinode occurs at any grid position exactly in line with at least two antennas of the same frequency, regardless of distance. This means that some of the new antinodes will occur at the position of each antenna (unless that antenna is the only one of its frequency).

  So, these three T-frequency antennas now create many antinodes:

  T....#....
  ...T......
  .T....#...
  .........#
  ..#.......
  ..........
  ...#......
  ..........
  ....#.....
  ..........

  In fact, the three T-frequency antennas are all exactly in line with two antennas, so they are all also antinodes! This brings the total number of antinodes in the above example to 9.

  The original example now has 34 antinodes, including the antinodes that appear on every antenna:

  ##....#....#
  .#.#....0...
  ..#.#0....#.
  ..##...0....
  ....0....#..
  .#...#A....#
  ...#..#.....
  #....#.#....
  ..#.....A...
  ....#....A..
  .#........#.
  ...#......##

  Calculate the impact of the signal using this updated model. How many unique locations within the bounds of the map contain an antinode?
  """
  def part2(args) do
    lines = String.split(args, "\n", trim: true)
    max_x = String.length(hd(lines)) - 1

    solve(args, &find_antinodes_part2(&1, &2, max_x))
  end
end
