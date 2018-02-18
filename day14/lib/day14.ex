defmodule Day14 do
  @moduledoc """
  Documentation for Day14.
  """

  def hash(value) do
    String.downcase(Base.encode16(:crypto.hash(:md5, value)))
  end

  def encode(seed,val) do
    hash(seed <> Integer.to_string(val))
  end


  def stretch_encode(seed, value) do
    stretch encode(seed,value), 2016
  end
  
  def stretch(code, loops) do
    if loops == 0 do
      code
    else
      stretch(hash(code), loops - 1)
    end
  end

  def get_encoding(seed, value, encoder, codes) do
    if Map.has_key?(codes, value) do
      { Map.get(codes, value), codes }
    else
      code = encoder.(seed,value)
      { code, Map.put(codes, value, code) }
    end
  end
  
  def find_a_triple(seed, value, encoder, codes \\ %{}) do
    { code, updated_codes } = get_encoding(seed,value, encoder, codes)
    case Regex.run(~r/^.*([0-9a-f])\1{2}.*$/, code) do
      [ _, char ] ->
        { char, updated_codes }
      _ ->
        { nil, updated_codes }
    end
  end

  def find_a_matching_five(seed, value, char, encoder, codes \\ %{}) do
    { code, updated_codes } = get_encoding(seed, value, encoder, codes)
    { _, r } = Regex.compile("^.*(" <> char <> ")\\1{4}.*$")
    { Regex.match?(r, code), updated_codes }
  end

  def has_a_matching_five(seed, value, char, encoder, codes \\ %{}, n \\ 0) do
    if n === 998 do
      { false, codes }
    else
      case find_a_matching_five(seed, value, char, encoder, codes) do
        { true, codes } ->
          { true, codes }
        { false, codes } ->
          has_a_matching_five(seed, value+1, char, encoder, codes, n+1)
      end
    end
  end
      
  def find_keys(seed, value, max, encoder, codes \\ %{}, keys \\ []) do
    if Enum.count(keys) == max do
      keys
    else
      case find_a_triple(seed, value, encoder, codes) do
        { nil, codes } ->
          find_keys(seed, value+1, max, encoder, codes, keys)
        { char, codes } ->
          case has_a_matching_five(seed, value+1, char, encoder, codes) do
            { true, codes } ->
              find_keys(seed, value+1, max, encoder, codes, keys ++ [value])
            { false, codes } ->
              find_keys(seed, value+1, max, encoder, codes, keys)
          end
      end
    end
  end

  def main(_args) do
    part1 = Enum.at(find_keys("zpqevtbw", 0, 65, &encode/2),64)
    IO.puts "Part1 #{part1}"
    part2 = Enum.at(find_keys("zpqevtbw", 0, 64, &stretch_encode/2),63)
    IO.puts "Part2 #{part2}"
  end
end
