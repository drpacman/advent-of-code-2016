defmodule Day2 do
  @moduledoc """
  Documentation for Day2.
  """

  def key_to_grid_part1(key) do
    x = rem(key - 1, 3) - 1
    y = div(key - 1, 3) - 1
    [ x, y ]
  end

  def grid_to_key_part1([x,y]) do
    ((y + 1) * 3) + x + 2
  end
  
  def navigate_part1(key, instr) do
    case key do
      [ x, y ] ->
        case instr do
          "U" -> [ x, max(y-1,-1) ]
          "D" -> [ x, min(y+1,1) ]
          "L" -> [ max(x-1,-1), y ]
          "R" -> [ min(x+1,1), y ]
        end
       _ ->
        navigate_part1(key_to_grid_part1(key), instr)
    end
  end

  def key_to_grid_part2(key) do
    cond do
      key == 1 ->
        [ 0, -2 ]
      key >=2 && key <=4 ->
        [ (key - 3), -1 ]
      key >=5 && key <=9 ->
        [ (key - 7), 0 ]
      key >= 10 && key <= 12 ->
        [ (key - 11), 1 ]
      true ->
        [ 0, 2 ]
    end
  end

  def grid_to_key_part2([x,y]) do
    cond do
      y == -2 ->
        1
      y == -1 ->
        (x+3)
      y == 0 ->
        (x+7)
      y == 1 ->
        :binary.list_to_bin([?a + (x + 1)])
      true ->
        "d"
    end
  end
  
  def navigate_part2(key, instr) do
    case key do
      [ x, y ] ->
        case instr do
          "U" -> [ x, max(y-1, -(2-abs(x))) ]
          "D" -> [ x, min(y+1, (2-abs(x))) ]
          "L" -> [ max(x-1,-(2-abs(y))), y ]
          "R" -> [ min(x+1, (2-abs(y))), y ]
        end
       _ ->
        navigate_part2(key_to_grid_part2(key), instr)
    end
  end

  def key_after_seq(key, instrs, resolver) do
    { navigator, key_to_grid, grid_to_key } = resolver
    pos = key_to_grid.(key)
    end_pos = Enum.reduce(String.codepoints(instrs), pos, &(navigator.(&2,&1)))
    grid_to_key.(end_pos)
  end

  def generate_sequence(instrs, start, resolver) do 
   Enum.reduce(instrs, [start], fn(instr, keys) -> ( [ key_after_seq(hd(keys), instr, resolver) ] ++ keys ) end) |> Enum.reverse |> tl
  end

  def generate_sequence_from_file( filename, start, resolver) do
    read_input(filename) |> generate_sequence(start, resolver)
  end
  
  def read_input(filename) do
    String.split(String.trim(File.read!(filename), "\n"))
  end

  def main(_args) do
    part1 = generate_sequence_from_file("resources/input.txt", 5, { &navigate_part1/2, &key_to_grid_part1/1, &grid_to_key_part1/1 })
    IO.inspect part1, label: "Part 1"
    part2 = generate_sequence_from_file("resources/input.txt", 7, { &navigate_part2/2, &key_to_grid_part2/1, &grid_to_key_part2/1 })
    IO.inspect part2, label: "Part 2"
  end
end
