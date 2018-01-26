defmodule Day4 do
  @moduledoc """
  Documentation for Day4.
  """

  def extract(code) do
    case Regex.run( ~r/(.*)-(\d+)\[(\w{5})\]/, code) do
      [ _, r, s, c ] ->
        { r, String.to_integer(s), String.codepoints(c) }
    end
  end

  def checksum(room) do
    Enum.filter(String.codepoints(room), &(&1 != "-"))
    |> Enum.group_by(&(&1))
    |> Enum.map(fn({k,v}) -> { k, Enum.count(v) } end)
    |> Enum.sort(fn({k1,v1},{k2,v2})-> v2<v1 || (v2==v1 && k2>k1) end)
    |> Enum.map(fn({k,_v}) -> k end)
    |> Enum.take(5)
  end

  def filter_valid_rooms(rooms) do
    Enum.map(rooms, &(extract &1))
    |> Enum.filter(fn({r,_,c}) -> checksum(r) == c end)
  end

  def sum_of_valid_room_sector_ids(rooms) do
    filter_valid_rooms(rooms)
    |> Enum.reduce(0, fn({_,s,_}, acc)-> acc+s end)
  end

  def read_input(filename) do
    File.read!(filename) |> String.trim() |> String.split("\n")
  end

  def decrypt_room(room) do
    case extract(room) do
      { r, s, _c } ->
        { decrypt(r, rem(s,26)), s }
    end
  end
  
  def decrypt(room_name, shift) do
    Enum.map String.to_charlist(room_name), fn(c)->
      case c do
        ?- ->
          ?\ 
        x ->
          ?a + rem(((x - ?a) + shift), 26) 
      end
    end
  end

  def find_room(filename, target) do
    Enum.map(read_input(filename), &(decrypt_room &1))
    |> Enum.filter( fn({r,_})->
      String.contains?(to_string(r), target)
    end)
  end
  
  def main(_args \\ "") do
    part1 = sum_of_valid_room_sector_ids(read_input("resources/input.txt"))
    IO.puts "Part 1 is #{part1}"
    part2 = find_room("resources/input.txt", "north")
    IO.inspect part2, label: "Part 2 is"
  end
end
