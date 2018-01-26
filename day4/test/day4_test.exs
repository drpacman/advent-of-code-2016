defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "extracts code, sector and checksum" do
    assert Day4.extract("aaaaa-bbb-z-y-x-123[abxyz]") == { "aaaaa-bbb-z-y-x", 123, ["a", "b", "x", "y", "z" ] }
  end

  test "finds common groups of chars" do
    assert Day4.checksum("aaaaa-bbb-z-y-x") == ["a", "b", "x", "y", "z" ]
    assert Day4.checksum("a-b-c-d-e-f-g-h") == ["a","b","c","d","e"]
  end

  test "finds valid rooms" do
    assert Day4.filter_valid_rooms(
      ["aaaaa-bbb-z-y-x-123[abxyz]",
       "a-b-c-d-e-f-g-h-987[abcde]",
       "not-a-real-room-404[oarel]",
       "totally-real-room-200[decoy]"]) ==
      [{"aaaaa-bbb-z-y-x", 123, ["a","b","x","y","z"]},
       {"a-b-c-d-e-f-g-h", 987, ["a","b","c","d", "e"]},
       {"not-a-real-room", 404, ["o","a","r","e","l"]}]
  end

  test "find sum of sector ids from valid room" do
    assert Day4.sum_of_valid_room_sector_ids(
      ["aaaaa-bbb-z-y-x-123[abxyz]",
       "a-b-c-d-e-f-g-h-987[abcde]",
       "not-a-real-room-404[oarel]",
       "totally-real-room-200[decoy]"]) == 1514
  end

  test "decrypt works" do
    assert Day4.decrypt("aaaaa-bbb-z-y-x",1) == 'bbbbb ccc a z y'
  end
                                     
end
