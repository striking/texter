defmodule FileUtilTest do
  use ExUnit.Case
  alias Texter.FileUtil
  # doctest Texter.FileUtil

  test "reads in a file and returns {:ok, content}" do
    result = FileUtil.handle_file("space.txt") 
    
    assert result == {:ok, content}
  end

  test "File error returns error tuple" do
    result = FileUtil.handle_file("no_file.txt") 
    
    assert result == {:ok, error}
  end
end
