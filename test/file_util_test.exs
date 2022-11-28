defmodule FileUtilTest do
  use ExUnit.Case
  alias Texter.FileUtil
  # doctest Texter.FileUtil

  # put real data
  # ensure happy path is working and error path - something unexpected
  # add test cases to cover pipe & comma

  test "reads in a file and returns {:ok, content}" do
    {:ok, content} = FileUtil.handle_file("space.txt")

    assert content ==
             "Kournikova Anna F F 6-3-1975 Red \nHingis Martina M F 4-2-1979 Green\nSeles Monica H F 12-2-1973 Black\n"
  end

  test "File error returns error tuple" do
    {:error, msg} = FileUtil.handle_file("no_file.txt")

    assert msg == "could not find no_file.txt"
  end
end
