defmodule Day7Test do
  use ExUnit.Case
  doctest Day7

  test "is valid if contains abba" do
    assert Day7.is_valid_part1("abba[mnop]qrst")
    assert Day7.is_valid_part1("ioxxoj[asdfgh]zxcvbn")
    assert Day7.is_valid_part1("aaaa[qwer]tyui") == false
  end

  test "is invalid if [] bit contains abba" do
    assert Day7.is_valid_part1("abba[abba]qrst") == false 
    assert Day7.is_valid_part1("abba[aaaa]qrst") 
  end

  test "is valid" do
    assert Day7.is_valid_part1("prjupstfryhiyxjr[nznibizpdpgsxozff]omzpiwgyqqytncz[ixhfkzmhfpctiaflrsg]fkxetrnjkjhwmbcs[mgfwcdxioxwsbpbxg]pnmcyowtigkikfbqem")
    assert Day7.is_valid_part1("xyz[1234]abba") == true
    assert Day7.is_valid_part1("[kkkk]abba") == true
  end

  test "is valid part2" do
    assert Day7.is_valid_part2("aba[bab]xyz") == true
    assert Day7.is_valid_part2("aaa[bab]abaxyz") == true
    assert Day7.is_valid_part2("aaa[aaa]abaxyz") == false
    assert Day7.is_valid_part2("aaa[aaa]aba[aba]xyz") == false
    assert Day7.is_valid_part2("aba[aba]xyz") == false
  end

  test "validate file" do
    assert Day7.validate_file_part1("resources/input_test.txt") == 3
  end
end
