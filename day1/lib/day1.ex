defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  @doc """
    Hello world.

    Examples

  iex> Day1.navigate([0,0], "R1", :north)
  { [1,0], :east }
      
  
  """
  def navigate( pos, instruction, direction \\ :north) do
    [ x, y ] = pos
    case Regex.run(~r/([LR])([0-9]+)/, instruction ) do
      [ _, "L", n ] ->
        case direction do
          :north -> { [ x - String.to_integer(n), y ], :west }
          :south -> { [ x + String.to_integer(n), y ], :east }
          :east -> { [ x, y + String.to_integer(n) ], :north }
          :west -> { [ x, y - String.to_integer(n) ], :south }
        end
      [ _, "R", n ] ->
        case direction do
          :north -> { [ x + String.to_integer(n), y ], :east }
          :south -> { [ x - String.to_integer(n), y ], :west }
          :east -> { [ x, y - String.to_integer(n) ], :south }
          :west -> { [ x, y + String.to_integer(n) ], :north }
        end
    end
  end

  def navigate_all(instructions) do
    Enum.reduce(instructions,
                { [0,0], :north },
                fn(instr, { pos, dir }) ->
                   navigate(pos, instr, dir)
                end)
  end

  def is_existing_location(locations, location) do
    Enum.any?(locations, &(&1 == location))
  end
  
  def find_first_duplicate(instructions, pos \\ [0,0], dir \\ :north, locations \\ []) do
    case instructions do
      [] ->
        false
      [ head | tail ] ->
        { new_pos, new_dir } = navigate(pos, head, dir)
        new_locations = generate_locations(pos, new_pos)
        duplicate = Enum.find( new_locations, &( is_existing_location(locations, &1) ))
        if (duplicate) do
          duplicate
        else
          find_first_duplicate(tail, new_pos, new_dir, new_locations ++ locations)
        end
    end
  end

  def generate_locations( [x1, y1], [x2, y2]) do
    tl (
      cond do
        (x1 == x2) -> Enum.map((y1..y2), &([x1, &1]))
        true -> Enum.map((x1..x2), &([&1, y1]))
      end
      )
  end
    
  def load_instructions() do
    String.split(File.read!("resources/input.txt"), ",")
  end

  def main(_args \\ []) do
    instrs = load_instructions()
    { [x,y], dir } = navigate_all(instrs)
    IO.puts("Part 1 is #{abs(x) + abs(y)}")
    [dx, dy ] = find_first_duplicate(instrs)
    IO.puts("Part 2 is #{abs(dx) + abs(dy)}")
  end
end
