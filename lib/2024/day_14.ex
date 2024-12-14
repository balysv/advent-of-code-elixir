defmodule AdventOfCode.Y2024.Day14 do
  defp parse_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [pos, vel] = String.split(line, " ")

      [px, py] =
        pos |> String.trim_leading("p=") |> String.split(",") |> Enum.map(&String.to_integer/1)

      [vx, vy] =
        vel |> String.trim_leading("v=") |> String.split(",") |> Enum.map(&String.to_integer/1)

      {{px, py}, {vx, vy}}
    end)
  end

  defp move_robot({{x, y}, {dx, dy}}, width, height) do
    new_x = rem(x + dx + width, width)
    new_y = rem(y + dy + height, height)
    {{new_x, new_y}, {dx, dy}}
  end

  defp simulate_robots(robots, seconds, width, height) do
    Enum.reduce(1..seconds, robots, fn _second, acc ->
      Enum.map(acc, &move_robot(&1, width, height))
    end)
  end

  defp count_quadrants(robots, width, height) do
    positions = Enum.map(robots, fn {pos, _} -> pos end)
    mid_x = div(width, 2)
    mid_y = div(height, 2)

    quadrants =
      positions
      |> Enum.reject(fn {x, y} -> x == mid_x || y == mid_y end)
      |> Enum.map(fn {x, y} ->
        cond do
          # top-left
          x < mid_x && y < mid_y -> 0
          # top-right
          x > mid_x && y < mid_y -> 1
          # bottom-left
          x < mid_x && y > mid_y -> 2
          # bottom-right
          x > mid_x && y > mid_y -> 3
        end
      end)
      |> Enum.frequencies()
      |> Map.values()

    Enum.product(quadrants)
  end

  @doc """
  --- Day 14: Restroom Redoubt ---

  One of The Historians needs to use the bathroom; fortunately, you know there's a bathroom near an unvisited location on their list, and so you're all quickly teleported directly to the lobby of Easter Bunny Headquarters.

  Unfortunately, EBHQ seems to have "improved" bathroom security again after your last visit. The area outside the bathroom is swarming with robots!

  To get The Historian safely to the bathroom, you'll need a way to predict where the robots will be in the future. Fortunately, they all seem to be moving on the tile floor in predictable straight lines.

  You make a list (your puzzle input) of all of the robots' current positions (p) and velocities (v), one robot per line. For example:

  p=0,4 v=3,-3
  p=6,3 v=-1,-3
  p=10,3 v=-1,2
  p=2,0 v=2,-1
  p=0,0 v=1,3
  p=3,0 v=-2,-2
  p=7,6 v=-1,-3
  p=3,0 v=-1,-2
  p=9,3 v=2,3
  p=7,3 v=-1,2
  p=2,4 v=2,-3
  p=9,5 v=-3,-3

  Each robot's position is given as p=x,y where x represents the number of tiles the robot is from the left wall and y represents the number of tiles from the top wall (when viewed from above). So, a position of p=0,0 means the robot is all the way in the top-left corner.

  Each robot's velocity is given as v=x,y where x and y are given in tiles per second. Positive x means the robot is moving to the right, and positive y means the robot is moving down. So, a velocity of v=1,-2 means that each second, the robot moves 1 tile to the right and 2 tiles up.

  The robots outside the actual bathroom are in a space which is 101 tiles wide and 103 tiles tall (when viewed from above). However, in this example, the robots are in a space which is only 11 tiles wide and 7 tiles tall.

  The robots are good at navigating over/under each other (due to a combination of springs, extendable legs, and quadcopters), so they can share the same tile and don't interact with each other. Visually, the number of robots on each tile in this example looks like this:

  1.12.......
  ...........
  ...........
  ......11.11
  1.1........
  .........1.
  .......1...

  These robots have a unique feature for maximum bathroom security: they can teleport. When a robot would run into an edge of the space they're in, they instead teleport to the other side, effectively wrapping around the edges. Here is what robot p=2,4 v=2,-3 does for the first few seconds:

  Initial state:
  ...........
  ...........
  ...........
  ...........
  ..1........
  ...........
  ...........

  After 1 second:
  ...........
  ....1......
  ...........
  ...........
  ...........
  ...........
  ...........

  After 2 seconds:
  ...........
  ...........
  ...........
  ...........
  ...........
  ......1....
  ...........

  After 3 seconds:
  ...........
  ...........
  ........1..
  ...........
  ...........
  ...........
  ...........

  After 4 seconds:
  ...........
  ...........
  ...........
  ...........
  ...........
  ...........
  ..........1

  After 5 seconds:
  ...........
  ...........
  ...........
  .1.........
  ...........
  ...........
  ...........

  The Historian can't wait much longer, so you don't have to simulate the robots for very long. Where will the robots be after 100 seconds?

  In the above example, the number of robots on each tile after 100 seconds has elapsed looks like this:

  ......2..1.
  ...........
  1..........
  .11........
  .....1.....
  ...12......
  .1....1....

  To determine the safest area, count the number of robots in each quadrant after 100 seconds. Robots that are exactly in the middle (horizontally or vertically) don't count as being in any quadrant, so the only relevant robots are:

  ..... 2..1.
  ..... .....
  1.... .....

  ..... .....
  ...12 .....
  .1... 1....

  In this example, the quadrants contain 1, 3, 4, and 1 robot. Multiplying these together gives a total safety factor of 12.

  Predict the motion of the robots in your list within a space which is 101 tiles wide and 103 tiles tall. What will the safety factor be after exactly 100 seconds have elapsed?

  Your puzzle answer was 209409792.
  --- Part Two ---

  During the bathroom break, someone notices that these robots seem awfully similar to ones built and used at the North Pole. If they're the same type of robots, they should have a hard-coded Easter egg: very rarely, most of the robots should arrange themselves into a picture of a Christmas tree.

  What is the fewest number of seconds that must elapse for the robots to display the Easter egg?

  """
  def part1(args) do
    robots = parse_input(args)
    width = 101
    height = 103
    seconds = 100

    robots
    |> simulate_robots(seconds, width, height)
    |> count_quadrants(width, height)
  end

  @doc """
    --- Part Two ---

  During the bathroom break, someone notices that these robots seem awfully similar to ones built and used at the North Pole. If they're the same type of robots, they should have a hard-coded Easter egg: very rarely, most of the robots should arrange themselves into a picture of a Christmas tree.

  What is the fewest number of seconds that must elapse for the robots to display the Easter egg?

  """
  def part2(args) do
    robots = parse_input(args)
    width = 101
    height = 103

    # Clear screen and hide cursor
    IO.write("\e[2J\e[H\e[?25l")

    try do
      Stream.iterate(0, &(&1 + 1))
      |> Enum.reduce_while(robots, fn seconds, current_robots ->
        next_robots = simulate_robots(current_robots, 1, width, height)
        positions = MapSet.new(Enum.map(next_robots, fn {pos, _} -> pos end))

        # code to inspect the tree
        if seconds > 8000 and seconds < 8007 do
          # Build the entire frame as a single string
          # Clear screen and move cursor to top
          # frame =
          #   "\e[2J\e[H" <>
          #     build_grid(positions, width, height) <>
          #     "Second: #{seconds}\n"

          # Print the entire frame at once
          # IO.write(frame)
          # Process.sleep(20)
        end

        if is_christmas_tree_pattern?(positions) do
          {:halt, seconds + 1}
        else
          {:cont, next_robots}
        end
      end)
    after
      # Show cursor again when done
      IO.write("\e[?25h")
    end
  end

  defp build_grid(positions, width, height) do
    for y <- 0..(height - 1) do
      for x <- 0..(width - 1) do
        if MapSet.member?(positions, {x, y}), do: "#", else: "."
      end
      |> Enum.join()
    end
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  # doesnt' really work
  defp is_christmas_tree_pattern?(positions) do
    # Convert positions to a list and find the bounds
    pos_list = MapSet.to_list(positions)
    {_, min_y} = Enum.min_by(pos_list, fn {_, y} -> y end)
    {_, max_y} = Enum.max_by(pos_list, fn {_, y} -> y end)

    # Check each row
    Enum.any?(min_y..max_y, fn y ->
      # Get all x positions in this row
      x_positions =
        pos_list
        |> Enum.filter(fn {_, py} -> py == y end)
        |> Enum.map(fn {x, _} -> x end)
        |> Enum.sort()

      # Check if we have exactly 8 consecutive positions
      length(x_positions) == 5 &&
        Enum.chunk_every(x_positions, 2, 1, :discard)
        |> Enum.all?(fn [a, b] -> b - a == 1 end)
    end)
  end
end
