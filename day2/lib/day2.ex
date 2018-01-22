defmodule Day2 do
  @moduledoc """
  Documentation for Day2.
  """

  def key_to_grid(key) do
    x = rem(key - 1, 3)
    y = div(key - 1, 3)
    [ x, y ]
  end

  def grid_to_key([x,y]) do
    ((y * 3) + x) + 1
  end
  
  def navigate(key, instr) do
    case key do
      [ x, y ] ->
        case instr do
          "U" -> [ x, max(y-1,0) ]
          "D" -> [ x, min(y+1,2) ]
          "L" -> [ max(x-1,0), y ]
          "R" -> [ min(x+1,2), y ]
        end
       _ ->
        navigate(key_to_grid(key), instr)
    end
  end

  def key_after_seq(key, instrs) do
    pos = key_to_grid(key)
    end_pos = Enum.reduce(String.codepoints(instrs), pos, &(navigate(&2,&1)))
    grid_to_key(end_pos)
  end

  def generate_sequence(instrs) do 
   Enum.reduce(instrs, [5], fn(instr, keys) -> ( [ key_after_seq(hd(keys), instr) ] ++ keys ) end) |> Enum.reverse |> tl
  end

  def generate_sequence_from_file( filename ) do
    read_input(filename) |> generate_sequence
  end
  
  def read_input(filename) do
    String.split(String.trim(File.read!(filename), "\n"))
  end

  def main(_args) do
    part1 = generate_sequence_from_file("resources/input.txt")
    IO.inspect part1, label: "Part 1"
  end
end
