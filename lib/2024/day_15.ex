defmodule AdventOfCode.Y2024.Day15 do
  defp parse_input(args) do
    [map_str, moves_str] =
      args
      |> String.split("\n\n", trim: true)

    map =
      map_str
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, x}, acc ->
          Map.put(acc, {x, y}, char)
        end)
      end)

    moves =
      moves_str
      |> String.replace("\n", "")
      |> String.graphemes()

    {map, moves}
  end

  defp find_robot(map) do
    Enum.find_value(map, fn {pos, char} -> if char == "@", do: pos end)
  end

  defp move_direction("^"), do: {0, -1}
  defp move_direction("v"), do: {0, 1}
  defp move_direction("<"), do: {-1, 0}
  defp move_direction(">"), do: {1, 0}

  defp add_pos({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}

  defp try_move(map, robot_pos, dir) do
    next_pos = add_pos(robot_pos, move_direction(dir))

    case Map.get(map, next_pos) do
      # Hit wall, no movement
      "#" ->
        map

      # Empty space, move robot
      "." ->
        map
        |> Map.put(robot_pos, ".")
        |> Map.put(next_pos, "@")

      # Box, try to push
      "O" ->
        # Find all consecutive boxes and the first non-box space
        boxes = find_consecutive_boxes(map, next_pos, dir)
        final_pos = add_pos(List.last(boxes), move_direction(dir))

        case Map.get(map, final_pos) do
          # Can push all boxes
          "." ->
            # Move robot
            map = Map.put(map, robot_pos, ".")
            map = Map.put(map, next_pos, "@")
            # Move all boxes one position forward
            Enum.reduce(Enum.zip(boxes, tl(boxes) ++ [final_pos]), map, fn {_from, to}, acc ->
              Map.put(acc, to, "O")
            end)

          # Can't push boxes
          _ ->
            map
        end
    end
  end

  defp find_consecutive_boxes(map, start_pos, dir) do
    Stream.iterate(start_pos, &add_pos(&1, move_direction(dir)))
    |> Enum.take_while(fn pos -> Map.get(map, pos) == "O" end)
    |> then(&[start_pos | &1])
    |> Enum.drop(1)
  end

  defp print_map(map) do
    {min_x, max_x} = map |> Map.keys() |> Enum.map(&elem(&1, 0)) |> Enum.min_max()
    {min_y, max_y} = map |> Map.keys() |> Enum.map(&elem(&1, 1)) |> Enum.min_max()

    output = [
      "\nCurrent map:\n",
      for y <- min_y..max_y do
        row = for x <- min_x..max_x, do: Map.get(map, {x, y}, " ")
        Enum.join(row) <> "\n"
      end,
      "\n"
    ]

    IO.write(output)
  end

  defp calculate_gps_coordinates(map) do
    map
    |> Enum.filter(fn {_pos, char} -> char == "O" end)
    |> Enum.map(fn {{x, y}, _} -> y * 100 + x end)
    |> Enum.sum()
  end

  @doc """

  """
  def part1(args) do
    {map, moves} = parse_input(args)

    final_map =
      Enum.reduce(moves, map, fn move, acc_map ->
        robot_pos = find_robot(acc_map)
        try_move(acc_map, robot_pos, move)
      end)

    calculate_gps_coordinates(final_map)
  end

  @doc """
    --- Part Two ---

  The lanternfish use your information to find a safe moment to swim in and turn off the malfunctioning robot! Just as they start preparing a festival in your honor, reports start coming in that a second warehouse's robot is also malfunctioning.

  This warehouse's layout is surprisingly similar to the one you just helped. There is one key difference: everything except the robot is twice as wide! The robot's list of movements doesn't change.

  To get the wider warehouse's map, start with your original map and, for each tile, make the following changes:

      If the tile is #, the new map contains ## instead.
      If the tile is O, the new map contains [] instead.
      If the tile is ., the new map contains .. instead.
      If the tile is @, the new map contains @. instead.

  This will produce a new warehouse map which is twice as wide and with wide boxes that are represented by []. (The robot does not change size.)

  The larger example from before would now look like this:

  ####################
  ##....[]....[]..[]##
  ##............[]..##
  ##..[][]....[]..[]##
  ##....[]@.....[]..##
  ##[]##....[]......##
  ##[]....[]....[]..##
  ##..[][]..[]..[][]##
  ##........[]......##
  ####################

  Because boxes are now twice as wide but the robot is still the same size and speed, boxes can be aligned such that they directly push two other boxes at once. For example, consider this situation:

  #######
  #...#.#
  #.....#
  #..OO@#
  #..O..#
  #.....#
  #######

  <vv<<^^<<^^

  After appropriately resizing this map, the robot would push around these boxes as follows:

  Initial state:
  ##############
  ##......##..##
  ##..........##
  ##....[][]@.##
  ##....[]....##
  ##..........##
  ##############

  Move <:
  ##############
  ##......##..##
  ##..........##
  ##...[][]@..##
  ##....[]....##
  ##..........##
  ##############

  Move v:
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[].@..##
  ##..........##
  ##############

  Move v:
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[]....##
  ##.......@..##
  ##############

  Move <:
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[]....##
  ##......@...##
  ##############

  Move <:
  ##############
  ##......##..##
  ##..........##
  ##...[][]...##
  ##....[]....##
  ##.....@....##
  ##############

  Move ^:
  ##############
  ##......##..##
  ##...[][]...##
  ##....[]....##
  ##.....@....##
  ##..........##
  ##############

  Move ^:
  ##############
  ##......##..##
  ##...[][]...##
  ##....[]....##
  ##.....@....##
  ##..........##
  ##############

  Move <:
  ##############
  ##......##..##
  ##...[][]...##
  ##....[]....##
  ##....@.....##
  ##..........##
  ##############

  Move <:
  ##############
  ##......##..##
  ##...[][]...##
  ##....[]....##
  ##...@......##
  ##..........##
  ##############

  Move ^:
  ##############
  ##......##..##
  ##...[][]...##
  ##...@[]....##
  ##..........##
  ##..........##
  ##############

  Move ^:
  ##############
  ##...[].##..##
  ##...@.[]...##
  ##....[]....##
  ##..........##
  ##..........##
  ##############

  This warehouse also uses GPS to locate the boxes. For these larger boxes, distances are measured from the edge of the map to the closest edge of the box in question. So, the box shown below has a distance of 1 from the top edge of the map and 5 from the left edge of the map, resulting in a GPS coordinate of 100 * 1 + 5 = 105.

  ##########
  ##...[]...
  ##........

  In the scaled-up version of the larger example from above, after the robot has finished all of its moves, the warehouse would look like this:

  ####################
  ##[].......[].[][]##
  ##[]...........[].##
  ##[]........[][][]##
  ##[]......[]....[]##
  ##..##......[]....##
  ##..[]............##
  ##..@......[].[][]##
  ##......[][]..[]..##
  ####################

  The sum of these boxes' GPS coordinates is 9021.

  Predict the motion of the robot and boxes in this new, scaled-up warehouse. What is the sum of all boxes' final GPS coordinates?

  """
  def part2(args) do
    {map, moves} = parse_input(args)
    scaled_map = scale_map(map)

    final_map =
      Enum.reduce(moves, scaled_map, fn move, acc_map ->
        robot_pos = find_robot(acc_map)
        try_move_v2(acc_map, robot_pos, move)
      end)

    calculate_gps_coordinates_v2(final_map)
  end

  defp scale_map(map) do
    map
    |> Enum.reduce(%{}, fn {{x, y}, char}, acc ->
      case char do
        "#" -> Map.merge(acc, %{{x * 2, y} => "#", {x * 2 + 1, y} => "#"})
        "O" -> Map.merge(acc, %{{x * 2, y} => "[", {x * 2 + 1, y} => "]"})
        "." -> Map.merge(acc, %{{x * 2, y} => ".", {x * 2 + 1, y} => "."})
        "@" -> Map.merge(acc, %{{x * 2, y} => "@", {x * 2 + 1, y} => "."})
      end
    end)
  end

  defp is_box_left_part?(char), do: char == "["
  defp is_box_right_part?(char), do: char == "]"
  defp is_box_part?(char), do: is_box_left_part?(char) || is_box_right_part?(char)

  defp try_move_v2(map, robot_pos, dir) do
    next_pos = add_pos(robot_pos, move_direction(dir))
    next_char = Map.get(map, next_pos)

    cond do
      next_char == "#" ->
        # Hit wall, no movement
        map

      next_char == "." ->
        # Empty space, move robot
        map
        |> Map.put(robot_pos, ".")
        |> Map.put(next_pos, "@")

      is_box_part?(next_char) ->
        # Box, try to push
        # Find all boxes in the direction of movement
        boxes =
          find_consecutive_boxes_v2(map, next_pos, dir)
          |> Enum.filter(&is_box_left_part?(Map.get(map, &1)))

        # Check if there's space after each box
        can_move =
          Enum.all?(boxes, fn box_pos ->
            check_pos = add_pos(box_pos, move_direction(dir))
            next_pos = Map.get(map, check_pos)
            a = next_pos == "." || is_box_part?(next_pos)

            check_2_pos = box_pos |> add_pos({1, 0}) |> add_pos(move_direction(dir))
            next_pos_2 = Map.get(map, check_2_pos)
            b = next_pos_2 == "." || is_box_part?(next_pos_2)

            a and b
          end)

        # Also check the final position after the last box
        final_check_pos = add_pos(List.first(boxes), move_direction(dir))
        final_space = Map.get(map, final_check_pos)

        if can_move do
          map =
            if final_space in [".", "]"] do
              # First clear all box positions
              Enum.reduce(boxes, map, fn box_pos, acc ->
                acc
                |> Map.put(box_pos, ".")
                |> Map.put(add_pos(box_pos, {1, 0}), ".")
              end)
            end

          # Move robot
          map =
            map
            |> Map.put(robot_pos, ".")
            |> Map.put(next_pos, "@")

          # Move all boxes one position in the direction of movement
          boxes
          |> Enum.sort_by(fn {x, y} ->
            case dir do
              # Sort by y descending for upward movement
              "^" -> -y
              # Sort by y ascending for downward movement
              "v" -> y
              # Sort by x descending for leftward movement
              "<" -> -x
              # Sort by x ascending for rightward movement
              ">" -> x
            end
          end)
          |> Enum.reduce(map, fn box_pos, acc ->
            new_pos = add_pos(box_pos, move_direction(dir))

            acc
            |> Map.put(new_pos, "[")
            |> Map.put(add_pos(new_pos, {1, 0}), "]")
          end)
        else
          # Can't push boxes
          map
        end
    end
  end

  defp get_box_pair(map, pos) do
    cond do
      is_box_left_part?(Map.get(map, pos)) ->
        [pos, add_pos(pos, {1, 0})]

      is_box_right_part?(Map.get(map, pos)) ->
        [add_pos(pos, {-1, 0}), pos]

      true ->
        []
    end
  end

  defp find_consecutive_boxes_v2(map, start_pos, dir, acc \\ []) do
    [left, right] = box = get_box_pair(map, start_pos)
    acc = [left, right | acc]

    [add_pos(left, move_direction(dir)), add_pos(right, move_direction(dir))]
    |> Enum.reject(&(&1 in box))
    |> Enum.flat_map(fn pos ->
      if is_box_part?(Map.get(map, pos)) do
        find_consecutive_boxes_v2(map, pos, dir, acc)
      else
        acc
      end
    end)
  end

  defp calculate_gps_coordinates_v2(map) do
    map
    |> Enum.filter(fn {_pos, char} -> is_box_left_part?(char) end)
    |> Enum.map(fn {{x, y}, _} -> y * 100 + x end)
    |> Enum.sum()
  end
end
