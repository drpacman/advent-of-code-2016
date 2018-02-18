defmodule Day16 do
  @moduledoc """
  Documentation for Day16.
  """
  import Bitwise
  require Integer
  
  def next(input) do
    b = Enum.reverse(input) |> Enum.map(fn(x)-> bxor(x,1) end)
    input ++ [ 0 ] ++ b
  end

  def fill(input, target_len) do
    if Enum.count(input) < target_len do
      fill(next(input), target_len)
    else
      Enum.take(input, target_len)
    end
  end
  
  def checksum(input) do
    chk = Enum.chunk_every(input, 2) |> Enum.map(fn([a,b])-> bxor(bxor(a,b),1) end)
    if Integer.is_odd(Enum.count(chk)) do
      chk
    else
      checksum(chk)
    end 
  end

  def result(input, target_len) do
    checksum(fill(input, target_len))
  end

  def main(_args) do
    p1 = result([1,0,0,1,1,1,1,1,0,1,1,0,1,1,0,0,1], 272)
    IO.inspect p1, label: "Part1"
    p2 = result([1,0,0,1,1,1,1,1,0,1,1,0,1,1,0,0,1], 35651584)
    IO.inspect p2, label: "Part2"
  end

end
