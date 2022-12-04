defmodule AdventOfCode.Y2021.Day23 do
  use Memoize
  @depth 2 # part 1
  # @depth 4 # part 2

  def part1(args) do
    {hallway, rooms} = args
    recur(hallway, rooms, 0, 99_999_999_999)
  end

  defp recur(hallway, rooms, cost, min_cost) do

    if is_end(rooms) do
      n = if cost < min_cost, do: cost, else: min_cost
      IO.inspect(n)
      n
    else
      states = []
      states = states ++ moves_from_hallway(hallway, rooms, cost)
      states = states ++ moves_from_rooms(hallway, rooms, cost)
      states = Enum.sort_by(states, fn {_, _, cost} -> cost end, :asc)

      if length(states) == 0 do
        9_999_999
      else
        Enum.reduce(states, min_cost, fn {hallway, rooms, cost}, min ->
          if min <= cost do
            min
          else
            res = recur(hallway, rooms, cost, min)
            if res < min, do: res, else: min
          end
        end)
      end
    end
  end

  defp moves_from_hallway(hallway, rooms = [r1, r2, r3, r4], cost) do
    hallway
    |> Enum.with_index()
    |> Enum.filter(fn p -> can_go_home(p, hallway, rooms) end)
    |> Enum.map(fn
      {1, idx} ->
        hallway = List.replace_at(hallway, idx, 0)
        cost = cost + (abs(idx - 2) + (@depth - length(r1))) * 1
        r1 = [1 | r1]
        {hallway, [r1, r2, r3, r4], cost}

      {10, idx} ->
        hallway = List.replace_at(hallway, idx, 0)
        cost = cost + (abs(idx - 4) + (@depth - length(r2))) * 10
        r2 = [10 | r2]
        {hallway, [r1, r2, r3, r4], cost}

      {100, idx} ->
        hallway = List.replace_at(hallway, idx, 0)
        cost = cost + (abs(idx - 6) + (@depth - length(r3))) * 100
        r3 = [100 | r3]
        {hallway, [r1, r2, r3, r4], cost}

      {1000, idx} ->
        hallway = List.replace_at(hallway, idx, 0)
        cost = cost + (abs(idx - 8) + (@depth - length(r4))) * 1000
        r4 = [1000 | r4]
        {hallway, [r1, r2, r3, r4], cost}
    end)
  end

  def moves_from_rooms(hallway, rooms, cost) do
    rooms
    |> Enum.with_index()
    |> Enum.filter(fn {r, _} -> length(r) != 0 end)
    |> Enum.flat_map(fn item = {_, idx} ->
      moves_from_room(hallway, item, cost)
      |> Enum.map(fn {h, room, c} ->
        {h, List.replace_at(rooms, idx, room), c}
      end)
    end)
  end

  def moves_from_room(_, {[], _}), do: []

  defp moves_from_room(hallway = [l2, l1, _, p1, _, p2, _, p3, _, rh1, rh2], {r, 0}, cost) do
    if Enum.any?(r, fn i -> i != 1 end) do
      m = []
      m = if l1 == 0 and l2 == 0, do: [update_state(hallway, 0, r, 3, cost) | m], else: m
      m = if l1 == 0, do: [update_state(hallway, 1, r, 2, cost) | m], else: m
      m = if p1 == 0, do: [update_state(hallway, 3, r, 2, cost) | m], else: m
      m = if p1 == 0 and p2 == 0, do: [update_state(hallway, 5, r, 4, cost) | m], else: m
      m = if p1 == 0 and p2 == 0 and p3 == 0, do: [update_state(hallway, 7, r, 6, cost) | m], else: m
      m = if p1 == 0 and p2 == 0 and p3 == 0 and rh1 == 0, do: [update_state(hallway, 9, r, 8, cost) | m], else: m
      m = if p1 == 0 and p2 == 0 and p3 == 0 and rh1 == 0 and rh2 == 0, do: [update_state(hallway, 10, r, 9, cost) | m], else: m
      m
    else
      []
    end
  end

  defp moves_from_room(hallway = [l2, l1, _, p1, _, p2, _, p3, _, rh1, rh2], {r, 1}, cost) do
    if Enum.any?(r, fn i -> i != 10 end) do
      m = []
      m = if p1 == 0 and l1 == 0 and l2 == 0, do: [update_state(hallway, 0, r, 5, cost) | m], else: m
      m = if p1 == 0 and l1 == 0, do: [update_state(hallway, 1, r, 4, cost) | m], else: m
      m = if p1 == 0, do: [update_state(hallway, 3, r, 2, cost) | m], else: m
      m = if p2 == 0, do: [update_state(hallway, 5, r, 2, cost) | m], else: m
      m = if p2 == 0 and p3 == 0, do: [update_state(hallway, 7, r, 4, cost) | m], else: m
      m = if p2 == 0 and p3 == 0 and rh1 == 0, do: [update_state(hallway, 9, r, 6, cost) | m], else: m
      m = if p2 == 0 and p3 == 0 and rh1 == 0 and rh2 == 0, do: [update_state(hallway, 10, r, 7, cost) | m], else: m
      m
    else
      []
    end
  end

  defp moves_from_room(hallway = [l2, l1, _, p1, _, p2, _, p3, _, rh1, rh2], {r, 2}, cost) do
    if Enum.any?(r, fn i -> i != 100 end) do
      m = []
      m = if p1 == 0 and p2 == 0 and l1 == 0 and l2 == 0, do: [update_state(hallway, 0, r, 7, cost) | m], else: m
      m = if p1 == 0 and p2 == 0 and l1 == 0, do: [update_state(hallway, 1, r, 6, cost) | m], else: m
      m = if p1 == 0 and p2 == 0, do: [update_state(hallway, 3, r, 4, cost) | m], else: m
      m = if p2 == 0, do: [update_state(hallway, 5, r, 2, cost) | m], else: m
      m = if p3 == 0, do: [update_state(hallway, 7, r, 2, cost) | m], else: m
      m = if p3 == 0 and rh1 == 0, do: [update_state(hallway, 9, r, 4, cost) | m], else: m
      m = if p3 == 0 and rh1 == 0 and rh2 == 0, do: [update_state(hallway, 10, r, 5, cost) | m], else: m
      m
    else
      []
    end
  end

  defp moves_from_room(hallway = [l2, l1, _, p1, _, p2, _, p3, _, rh1, rh2], {r, 3}, cost) do
    if Enum.any?(r, fn i -> i != 1000 end) do
      m = []
      m = if p1 == 0 and p2 == 0 and p3 == 0 and l1 == 0 and l2 == 0, do: [update_state(hallway, 0, r, 9, cost) | m], else: m
      m = if p1 == 0 and p2 == 0 and p3 == 0 and l1 == 0, do: [update_state(hallway, 1, r, 8, cost) | m], else: m
      m = if p1 == 0 and p2 == 0 and p3 == 0, do: [update_state(hallway, 3, r, 6, cost) | m], else: m
      m = if p2 == 0 and p3 == 0, do: [update_state(hallway, 5, r, 4, cost) | m], else: m
      m = if p3 == 0, do: [update_state(hallway, 7, r, 2, cost) | m], else: m
      m = if rh1 == 0, do: [update_state(hallway, 9, r, 2, cost) | m], else: m
      m = if rh1 == 0 and rh2 == 0, do: [update_state(hallway, 10, r, 3, cost) | m], else: m
      m
    else
      []
    end
  end

  defp update_state(hallway, pos, room, distance, cost) do
    {
      List.replace_at(hallway, pos, hd(room)),
      tl(room),
      cost + (@depth - length(room) + distance) * hd(room)
    }
  end

  defp is_end([r1, r2, r3, r4]) do
    length(r1) == @depth and Enum.all?(r1, &(&1 == 1)) and
      length(r2) == @depth and Enum.all?(r2, &(&1 == 10)) and
      length(r3) == @depth and Enum.all?(r3, &(&1 == 100)) and
      length(r4) == @depth and Enum.all?(r4, &(&1 == 1000))
  end

  defp can_go_home({1, idx}, [_, l1, _, p1, _, p2, _, p3, _, rh1, _], [r, _, _, _]) do
    can_go_to_room(1, r) and
    ((idx == 0 and l1 == 0)
    or (idx == 1)
    or (idx == 3)
    or (idx == 5 and p1 == 0)
    or (idx == 7 and p1 == 0 and p2 == 0)
    or (idx == 9 and p1 == 0 and p2 == 0 and p3 == 0)
    or (idx == 10 and p1 == 0 and p2 == 0 and p3 == 0 and rh1 == 0))
  end



  defp can_go_home({10, idx}, [_, l1, _, p1, _, p2, _, p3, _, rh1, _], [_, r, _, _]) do
    can_go_to_room(10, r) and
    ((idx == 0 and l1 == 0 and p1 == 0)
    or (idx == 1 and p1 == 0)
    or (idx == 3)
    or (idx == 5)
    or (idx == 7 and p2 == 0)
    or (idx == 9 and p2 == 0 and p3 == 0)
    or (idx == 10 and p2 == 0 and p3 == 0 and rh1 == 0))
  end


  defp can_go_home({100, idx}, [_, l1, _, p1, _, p2, _, p3, _, rh1, _], [_, _, r, _]) do
    can_go_to_room(100, r) and
    ((idx == 0 and l1 == 0 and p1 == 0 and p2 == 0)
    or (idx == 1 and p1 == 0 and p2 == 0)
    or (idx == 3 and p2 == 0)
    or (idx == 5)
    or (idx == 7)
    or (idx == 9 and  p3 == 0)
    or (idx == 10 and p3 == 0 and rh1 == 0))
  end

  defp can_go_home({1000, idx}, [_, l1, _, p1, _, p2, _, p3, _, rh1, _], [_, _, _, r]) do
    can_go_to_room(1000, r) and
    ((idx == 0 and l1 == 0 and p1 == 0 and p2 == 0 and p3 == 0)
    or (idx == 1 and p1 == 0 and p2 == 0 and p3 == 0)
    or (idx == 3 and p2 == 0 and p3 == 0)
    or (idx == 5 and p3 == 0)
    or (idx == 7)
    or (idx == 9)
    or (idx == 10 and rh1 == 0))
  end

  defp can_go_to_room(s, room) do
    length(room) == 0 or Enum.all?(room, &(&1 == s))
  end

  defp print({hallway, rooms, cost}) do
    IO.puts("Cost: #{cost}")
    IO.puts("#############")
    IO.write("#")
    for h <- hallway, do: IO.write(char_for(h))
    IO.puts("#")

    rooms =
      rooms
      |> Enum.map(fn r ->
        if length(r) != @depth do
          e = @depth - length(r)
          Enum.reduce(1..e, r, fn _, acc -> [0 | acc] end)
        else
          r
        end
      end)

    for {d1, d2, d3, d4} <- Enum.zip(rooms) do
      IO.write("  ##{char_for(d1)}##{char_for(d2)}##{char_for(d3)}##{char_for(d4)}#")
      IO.puts("")
    end

    IO.puts("")
  end

  defp char_for(9), do: "."
  defp char_for(0), do: "."
  defp char_for(1), do: "A"
  defp char_for(10), do: "B"
  defp char_for(100), do: "C"
  defp char_for(1000), do: "D"

  def part2(args) do
  end
end
