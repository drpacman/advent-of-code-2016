defmodule Day8 do
  @moduledoc """
  Documentation for Day8.
  """

  def gen(a,b) do
    Enum.map(0..a-1, fn(x)->
      Enum.map(0..b-1, fn(y)-> {x,y}  end)
    end)
    |> Enum.concat
    |> MapSet.new
  end
  
  def rect(screen, a, b) do
    MapSet.union(screen, gen(a,b))
  end

  def rotate_row(screen, row, n, width) do
    Enum.map(screen, fn(entry) ->
      case entry do
        {x,y} when y==row ->
          { rem(x+n, width), y }
        entry ->
          entry
      end
    end) |> MapSet.new
  end

  def rotate_col(screen, col, n, height) do
    Enum.map(screen, fn(entry) ->
      case entry do
        {x,y} when x==col ->
          { x, rem(y+n, height) }
        entry ->
          entry
      end
    end) |> MapSet.new
  end

  def apply(screen, line, width, height) do
    case Regex.run(~r/rect (\d+)x(\d+)/, line) do
      [ _, x, y ] ->
        rect(screen, String.to_integer(x), String.to_integer(y))
      _ -> case Regex.run(~r/rotate row y=(\d+) by (\d+)/, line) do
             [ _, row, n ] ->
               rotate_row(screen, String.to_integer(row), String.to_integer(n), width)
             _ ->
               case Regex.run(~r/rotate column x=(\d+) by (\d+)/, line) do
                 [ _,col,n] ->
                   rotate_col(screen, String.to_integer(col), String.to_integer(n), height)
               end
           end
    end
  end

  def read_file(filename) do
    File.read!(filename) |> String.trim() |> String.split("\n")
  end

  def print_row(screen, row) do
    Enum.reduce 0..49, "", fn(x,acc)->
      if MapSet.member?(screen, {x,row}) do
        acc <> "1"
      else
        acc <> " "
      end
    end
  end

  def print_screen(screen) do
    Enum.each 0..5, fn(row) ->
      IO.puts print_row(screen, row)
    end
  end
  
  def main(_args) do
    contents = read_file ("resources/input.txt")
    screen = Enum.reduce(contents, MapSet.new(), fn(line,screen)-> apply(screen,line,50,6) end)
    IO.puts "Part1: #{Enum.count screen}"
    IO.puts "Part2: screen printout"
    print_screen(screen)
  end
  
end
