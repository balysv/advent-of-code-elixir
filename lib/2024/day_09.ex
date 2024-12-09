defmodule AdventOfCode.Y2024.Day09 do
  defp parse_input(args) do
    args
    |> String.split("\n", trim: true)
    |> List.first()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp create_disk(sizes) do
    {disk, _file_id} =
      sizes
      |> Enum.chunk_every(2)
      |> Enum.reduce({[], 0}, fn
        [file_size, space_size], {acc, file_id} ->
          file_blocks = List.duplicate(file_id, file_size)
          space_blocks = List.duplicate(".", space_size)
          {acc ++ file_blocks ++ space_blocks, file_id + 1}

        # Handle odd number of elements
        [file_size], {acc, file_id} ->
          file_blocks = List.duplicate(file_id, file_size)
          {acc ++ file_blocks, file_id + 1}
      end)

    disk
  end

  defp compact_disk(disk) do
    disk_size = length(disk)

    do_compact(disk, 0, disk_size)
  end

  defp do_compact(disk, pos, disk_size) when pos >= disk_size, do: disk

  defp do_compact(disk, pos, disk_size) do
    case Enum.at(disk, pos) do
      "." ->
        # Find the rightmost number (from the end of the disk)
        case Enum.reverse(disk)
             |> Enum.with_index()
             |> Enum.find(fn {val, _} -> is_integer(val) end) do
          nil ->
            disk

          {num, reverse_index} ->
            num_index = disk_size - 1 - reverse_index

            if num_index > pos do
              # Move the number to the dot position
              disk
              |> List.replace_at(pos, num)
              |> List.replace_at(num_index, ".")
              |> do_compact(pos + 1, disk_size)
            else
              disk
            end
        end

      _ ->
        do_compact(disk, pos + 1, disk_size)
    end
  end

  defp calculate_checksum(disk) do
    disk
    |> Enum.with_index()
    |> Enum.reduce(0, fn
      {".", _index}, acc -> acc
      {file_id, index}, acc -> acc + file_id * index
    end)
  end

  @doc """
  --- Day 9: Disk Fragmenter ---

  Another push of the button leaves you in the familiar hallways of some friendly amphipods! Good thing you each somehow got your own personal mini submarine. The Historians jet away in search of the Chief, mostly by driving directly into walls.

  While The Historians quickly figure out how to pilot these things, you notice an amphipod in the corner struggling with his computer. He's trying to make more contiguous free space by compacting all of the files, but his program isn't working; you offer to help.

  He shows you the disk map (your puzzle input) he's already generated. For example:

  2333133121414131402

  The disk map uses a dense format to represent the layout of files and free space on the disk. The digits alternate between indicating the length of a file and the length of free space.

  So, a disk map like 12345 would represent a one-block file, two blocks of free space, a three-block file, four blocks of free space, and then a five-block file. A disk map like 90909 would represent three nine-block files in a row (with no free space between them).

  Each file on disk also has an ID number based on the order of the files as they appear before they are rearranged, starting with ID 0. So, the disk map 12345 has three files: a one-block file with ID 0, a three-block file with ID 1, and a five-block file with ID 2. Using one character for each block where digits are the file ID and . is free space, the disk map 12345 represents these individual blocks:

  0..111....22222

  The first example above, 2333133121414131402, represents these individual blocks:

  00...111...2...333.44.5555.6666.777.888899

  The amphipod would like to move file blocks one at a time from the end of the disk to the leftmost free space block (until there are no gaps remaining between file blocks). For the disk map 12345, the process looks like this:

  0..111....22222
  02.111....2222.
  022111....222..
  0221112...22...
  02211122..2....
  022111222......

  The first example requires a few more steps:

  00...111...2...333.44.5555.6666.777.888899
  009..111...2...333.44.5555.6666.777.88889.
  0099.111...2...333.44.5555.6666.777.8888..
  00998111...2...333.44.5555.6666.777.888...
  009981118..2...333.44.5555.6666.777.88....
  0099811188.2...333.44.5555.6666.777.8.....
  009981118882...333.44.5555.6666.777.......
  0099811188827..333.44.5555.6666.77........
  00998111888277.333.44.5555.6666.7.........
  009981118882777333.44.5555.6666...........
  009981118882777333644.5555.666............
  00998111888277733364465555.66.............
  0099811188827773336446555566..............

  The final step of this file-compacting process is to update the filesystem checksum. To calculate the checksum, add up the result of multiplying each of these blocks' position with the file ID number it contains. The leftmost block is in position 0. If a block contains free space, skip it instead.

  Continuing the first example, the first few blocks' position multiplied by its file ID number are 0 * 0 = 0, 1 * 0 = 0, 2 * 9 = 18, 3 * 9 = 27, 4 * 8 = 32, and so on. In this example, the checksum is the sum of these, 1928.

  Compact the amphipod's hard drive using the process he requested. What is the resulting filesystem checksum? (Be careful copy/pasting the input for this puzzle; it is a single, very long line.)

  """
  def part1(args) do
    args
    |> parse_input()
    |> create_disk()
    |> compact_disk()
    |> calculate_checksum()
  end

  @doc """
  --- Part Two ---

  Upon completion, two things immediately become clear. First, the disk definitely has a lot more contiguous free space, just like the amphipod hoped. Second, the computer is running much more slowly! Maybe introducing all of that file system fragmentation was a bad idea?

  The eager amphipod already has a new plan: rather than move individual blocks, he'd like to try compacting the files on his disk by moving whole files instead.

  This time, attempt to move whole files to the leftmost span of free space blocks that could fit the file. Attempt to move each file exactly once in order of decreasing file ID number starting with the file with the highest file ID number. If there is no span of free space to the left of a file that is large enough to fit the file, the file does not move.

  The first example from above now proceeds differently:

  00...111...2...333.44.5555.6666.777.888899
  0099.111...2...333.44.5555.6666.777.8888..
  0099.1117772...333.44.5555.6666.....8888..
  0099.111777244.333....5555.6666.....8888..
  00992111777.44.333....5555.6666.....8888..

  The process of updating the filesystem checksum is the same; now, this example's checksum would be 2858.

  Start over, now compacting the amphipod's hard drive using this new method instead. What is the resulting filesystem checksum?

  """
  def part2(args) do
    disk = args |> parse_input() |> create_disk()

    # Get unique file IDs in descending order
    file_ids =
      disk
      |> Enum.filter(&is_integer/1)
      |> Enum.uniq()
      |> Enum.sort(:desc)

    # Move each file once
    final_disk = Enum.reduce(file_ids, disk, &move_file/2)

    calculate_checksum(final_disk)
  end

  defp move_file(file_id, disk) do
    # Find all blocks of the current file
    file_positions =
      disk
      |> Enum.with_index()
      |> Enum.filter(fn {val, _} -> val == file_id end)
      |> Enum.map(fn {_, idx} -> idx end)

    file_size = length(file_positions)

    # Find leftmost space that can fit the entire file
    case find_space_for_file(disk, file_size) do
      # No suitable space found
      nil ->
        disk

      start_pos ->
        if start_pos < List.first(file_positions) do
          # Move the file only if the space is to the left
          disk
          # Clear old positions
          |> fill_with_dots(file_positions)
          # Place file in new position
          |> fill_with_file(start_pos, file_size, file_id)
        else
          disk
        end
    end
  end

  defp find_space_for_file(disk, size) do
    disk
    |> Enum.with_index()
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.find(fn chunk ->
      Enum.all?(chunk, fn {val, _} -> val == "." end)
    end)
    |> case do
      nil -> nil
      # Get index of first position
      chunk -> elem(hd(chunk), 1)
    end
  end

  defp fill_with_dots(disk, positions) do
    Enum.reduce(positions, disk, fn pos, acc ->
      List.replace_at(acc, pos, ".")
    end)
  end

  defp fill_with_file(disk, start_pos, size, file_id) do
    Enum.reduce(0..(size - 1), disk, fn offset, acc ->
      List.replace_at(acc, start_pos + offset, file_id)
    end)
  end
end
