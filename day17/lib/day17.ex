defmodule Day17 do
  @moduledoc """
  Documentation for Day17.
  """

  def options(input) do
    <<a,b,_::binary>> = :crypto.hash(:md5, input)
    Enum.reduce([a,b], [], fn(x, acc)->
      if (x < 16) do
        acc ++ [ 0, x ]
      else
        acc ++ Integer.digits(x,16)
      end
    end) |> Enum.map(&(&1>10))
  end

  def moves(x, y, doors) do
    Enum.zip([["U", x,y-1],["D",x,y+1],["L",x-1, y],["R",x+1,y]], doors)
    |> Enum.filter(fn {[_,x,y],door_status} ->
      door_status && x>=0 && x<=3 && y>=0 && y<=3
    end)
    |> Enum.map(fn {move,_}-> move end)
  end

  def make_move(x,y,code) do
    moves(x, y, options(code))
  end

  def shortest_path_fast(input, locations \\ [ [0,0,""] ]) do
    moves = Enum.reduce(locations, [], fn([x,y,path],acc)->
      acc ++ Enum.map(make_move(x, y, input<>path), fn([dir,x,y])->
      [x,y,path<>dir]
      end)
    end)
    if Enum.empty?(moves) do
      -1
    else
      case Enum.find(moves, fn([x, y, _])-> x==3 && y==3 end) do
      [_,_,path] ->
        path
      _ ->
        shortest_path_fast(input, moves)
      end
    end
  end

  def shortest_path(input) do
    find_path(input, fn(candidate,current) -> String.length(candidate) < String.length(current) end)
  end

  def longest_path(input) do
    find_path(input, fn(candidate,current) -> String.length(candidate) > String.length(current) end)
  end

  def find_path(input, f) do
    Enum.reduce(all_paths(input), nil, fn(path, current)->
      if current == nil || f.(path, current) do
        path
      else
        current
      end
    end)
  end

  def all_paths(input, locations \\ [ [0,0,""] ], paths \\ []) do
    moves = Enum.reduce(locations, [], fn([x,y,path],acc)->
      acc ++ Enum.map(make_move(x, y, input<>path), fn([dir,x,y])->
      [x,y,path<>dir]
      end)
    end)
    if Enum.empty?(moves) do
      paths
    else
      { successes, remainder } = Enum.split_with(moves, fn([x, y, _])-> x==3 && y==3 end)
      all_paths(input, remainder, paths ++ Enum.map(successes, fn([_,_,path])-> path end))
    end
  end

  def main(_args) do
    part1 = shortest_path("qtetzkpl")
    IO.puts "Part1 #{part1}"
    part2 = String.length(longest_path("qtetzkpl"))
    IO.puts "Part2 #{part2}"
  end
end
