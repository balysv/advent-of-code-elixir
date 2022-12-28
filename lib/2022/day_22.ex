defmodule AdventOfCode.Y2022.Day22 do
  defp prepare_input(args) do
    [map, instrs] = String.split(args, "\n\n", trim: true)

    map =
      map
      |> String.split("\n", trim: true)
      |> Enum.with_index(1)
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.graphemes()
        |> Enum.with_index(1)
        |> Enum.map(fn {chr, x} ->
          {{x, y}, chr}
        end)
      end)
      |> Map.new()

    {start_pos, _} =
      map |> Enum.filter(&match?({{_, 1}, "."}, &1)) |> Enum.min_by(fn {{x, _}, _} -> x end)

    instrs =
      instrs
      |> String.graphemes()
      |> Enum.reduce({"", []}, fn chr, {prev, acc} ->
        cond do
          chr == "\n" -> [String.to_integer(prev) | acc]
          chr in ["L", "R"] -> {"", [chr, String.to_integer(prev) | acc]}
          true -> {prev <> chr, acc}
        end
      end)
      |> Enum.reverse()

    {map, start_pos, instrs}
  end

  @dirs ["R", "D", "L", "U"]

  defp line_for_coord(map, {_, y}, :x),
    do: map |> Enum.filter(&match?({{_, ^y}, _}, &1)) |> Enum.sort_by(fn {{x, _}, _} -> x end)

  defp line_for_coord(map, {x, _}, :y),
    do: map |> Enum.filter(&match?({{^x, _}, _}, &1)) |> Enum.sort_by(fn {{_, y}, _} -> y end)

  defp wrap_list(list, pos) do
    curr_pos_idx = Enum.find_index(list, fn {coord, _} -> coord == pos end)
    {f, s} = list |> List.delete({pos, "."}) |> Enum.split(curr_pos_idx)
    Enum.reject(s ++ f, &match?({_, " "}, &1))
  end

  defp move_line(map, pos, "R"), do: map |> line_for_coord(pos, :x) |> wrap_list(pos)
  defp move_line(map, pos, "D"), do: map |> line_for_coord(pos, :y) |> wrap_list(pos)
  defp move_line(map, pos, "L"), do: move_line(map, pos, "R") |> Enum.reverse()
  defp move_line(map, pos, "U"), do: move_line(map, pos, "D") |> Enum.reverse()

  defp move_by(line, steps, pos) do
    case Enum.take(line, steps) |> Enum.find_index(&match?({_, "#"}, &1)) do
      nil -> Enum.at(line, steps - 1) |> elem(0)
      0 -> pos
      wall -> Enum.at(line, wall - 1) |> elem(0)
    end
  end

  defp turn(facing, "R") do
    idx = (Enum.find_index(@dirs, &Kernel.==(&1, facing)) + 1) |> rem(4)
    Enum.at(@dirs, idx)
  end

  defp turn(facing, "L") do
    idx = Enum.find_index(@dirs, &Kernel.==(&1, facing)) - 1
    Enum.at(@dirs, idx)
  end

  defp score("R"), do: 0
  defp score("D"), do: 1
  defp score("L"), do: 2
  defp score("U"), do: 3

  def part1(args) do
    {map, start_pos, instrs} = prepare_input(args)

    {{x, y}, facing} =
      Enum.reduce(instrs, {start_pos, "R"}, fn
        instr, {pos, facing} when is_integer(instr) ->
          new_pos = map |> move_line(pos, facing) |> move_by(instr, pos)
          {new_pos, facing}

        instr, {pos, facing} ->
          {pos, turn(facing, instr)}
      end)

    1000 * y + 4 * x + score(facing)
  end

  defp cube_side_length(spaces) do
    x = spaces |> Enum.map(&elem(&1, 0)) |> Enum.max()
    y = spaces |> Enum.map(&elem(&1, 1)) |> Enum.max()
    Integer.gcd(x, y)
  end

  defp to_cube(map) do
    spaces = map |> Enum.filter(&match?({_, "."}, &1))
    side_length = cube_side_length(Enum.map(spaces, &elem(&1, 0)))

    for i <- 0..(side_length - 1), j <- 0..(side_length - 1) do
      coords =
        for x <- 1..side_length, y <- 1..side_length do
          x = x + i * side_length
          y = y + j * side_length

          {{x, y}, Map.get(map, {x, y})}
        end

      {{i, j}, coords}
    end
    |> Enum.reject(fn {_, side} ->
      Enum.any?(side, fn {_, e} -> e == " " or is_nil(e) end)
    end)
    |> Map.new()
  end

  defp find_cube_side_id(cube_sides, pos) do
    cube_sides
    |> Enum.find(fn {_, coords} ->
      Enum.any?(coords, &match?({^pos, _}, &1))
    end)
    |> elem(0)
  end

  @transitions %{
    {2, 0} => %{
      "R" => {{1, 2}, "L"},
      "D" => {{1, 1}, "L"},
      "L" => {{1, 0}, "L"},
      "U" => {{0, 3}, "U"}
    },
    {1, 0} => %{
      "R" => {{2, 0}, "R"},
      "D" => {{1, 1}, "D"},
      "L" => {{0, 2}, "R"},
      "U" => {{0, 3}, "R"}
    },
    {1, 1} => %{
      "R" => {{2, 0}, "U"},
      "D" => {{1, 2}, "D"},
      "L" => {{0, 2}, "D"},
      "U" => {{1, 0}, "U"}
    },
    {1, 2} => %{
      "R" => {{2, 0}, "L"},
      "D" => {{0, 3}, "L"},
      "L" => {{0, 2}, "L"},
      "U" => {{1, 1}, "U"}
    },
    {0, 2} => %{
      "R" => {{1, 2}, "R"},
      "D" => {{0, 3}, "D"},
      "L" => {{1, 0}, "R"},
      "U" => {{1, 1}, "R"}
    },
    {0, 3} => %{
      "R" => {{1, 2}, "U"},
      "D" => {{2, 0}, "D"},
      "L" => {{1, 0}, "D"},
      "U" => {{0, 2}, "U"}
    }
  }

  defp to_local_coords({x, y}), do: {rem(x - 1, 50) + 1, rem(y - 1, 50) + 1}

  defp to_global_coords({_lx, ly}, {1, 0}, "L", _), do: {1, 151 - ly}
  defp to_global_coords({lx, _ly}, {1, 0}, "U", _), do: {1, 150 + lx}

  defp to_global_coords({_lx, ly}, {2, 0}, "R", _), do: {100, 151 - ly}
  defp to_global_coords({lx, _ly}, {2, 0}, "U", _), do: {lx, 200}
  defp to_global_coords({lx, _ly}, {2, 0}, "D", _), do: {100, 50 + lx}

  defp to_global_coords({_lx, ly}, {1, 1}, "R", _), do: {100 + ly, 50}
  defp to_global_coords({_lx, ly}, {1, 1}, "L", _), do: {ly, 101}

  defp to_global_coords({lx, _ly}, {1, 2}, "D", _), do: {50, 150 + lx}
  defp to_global_coords({_lx, ly}, {1, 2}, "R", _), do: {150, 51 - ly}

  defp to_global_coords({lx, _ly}, {0, 2}, "U", _), do: {51, 50 + lx}
  defp to_global_coords({_lx, ly}, {0, 2}, "L", _), do: {51, 51 - ly}

  defp to_global_coords({lx, _ly}, {0, 3}, "D", _), do: {100 + lx, 1}
  defp to_global_coords({_lx, ly}, {0, 3}, "L", _), do: {50 + ly, 1}
  defp to_global_coords({_lx, ly}, {0, 3}, "R", _), do: {50 + ly, 150}

  defp to_global_coords({lx, ly}, _, _, [{{sx, sy}, _} | _]), do: {lx + sx - 1, ly + sy - 1}

  defp axis(facing) when facing in ["L", "R"], do: :x
  defp axis(facing) when facing in ["U", "D"], do: :y
  defp reverse(line, facing) when facing in ["D", "R"], do: line
  defp reverse(line, facing) when facing in ["U", "L"], do: Enum.reverse(line)

  defp add_facing(line, facing), do: Enum.map(line, &Tuple.append(&1, facing))

  defp move_line_p2(_, _, _, acc) when length(acc) >= 100, do: acc

  defp move_line_p2(cube_sides, pos, facing, acc) do
    side_id = find_cube_side_id(cube_sides, pos)
    axis = axis(facing)

    line =
      cube_sides
      |> Map.get(side_id)
      |> line_for_coord(pos, axis)
      |> reverse(facing)
      |> add_facing(facing)

    acc = acc ++ line

    {next_side_id, next_facing} = @transitions |> Map.get(side_id) |> Map.get(facing)
    next_side = Map.get(cube_sides, next_side_id)

    next_pos =
      pos
      |> to_local_coords()
      |> to_global_coords(side_id, facing, next_side)

    move_line_p2(cube_sides, next_pos, next_facing, acc)
  end

  defp move_by_p2(line, steps, pos, facing) do
    case Enum.take(line, steps) |> Enum.find_index(&match?({_, "#", _}, &1)) do
      nil ->
        {pos, _, facing} = Enum.at(line, steps - 1)
        {pos, facing}

      0 ->
        {pos, facing}

      wall ->
        {pos, _, facing} = Enum.at(line, wall - 1)
        {pos, facing}
    end
  end

  defp trim_line(line, {x, _}, "R"), do: Enum.drop(line, rem(x - 1, 50) + 1)
  defp trim_line(line, {_, y}, "D"), do: Enum.drop(line, rem(y - 1, 50) + 1)
  defp trim_line(line, {x, _}, "L"), do: Enum.drop(line, 50 - rem(x - 1, 50))
  defp trim_line(line, {_, y}, "U"), do: Enum.drop(line, 50 - rem(y - 1, 50))

  def part2(args) do
    {map, start_pos, instrs} = prepare_input(args)

    cube_sides = to_cube(map)


    {{x, y}, facing} =
      Enum.reduce(instrs, {start_pos, "R"}, fn
        instr, {pos, facing} when is_integer(instr) ->
          cube_sides
          |> move_line_p2(pos, facing, [])
          |> trim_line(pos, facing)
          |> move_by_p2(instr, pos, facing)

        instr, {pos, facing} ->
          {pos, turn(facing, instr)}
      end)

    1000 * y + 4 * x + score(facing)
  end
end
