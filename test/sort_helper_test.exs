defmodule SortHelperTest do
  use ExUnit.Case
  alias Texter.SortHelper

   @player_list [
      %{gender: "Female", last_name: "Smith", first_name: "something", dob: "1/1/200"},
      %{gender: "Male", last_name: "Smith", first_name: "something", dob: "1/1/200"},
      %{gender: "Female", last_name: "Zulu", first_name: "something", dob: "1/1/200"},
      %{gender: "Male", last_name: "Whiskey", first_name: "something", dob: "1/1/200"} 
    ]
  
  test "Sort by Gender" do
    result = SortHelper.sort_by_gender(@player_list)
  
    assert result == [
      "Smith something Female 1/1/200 \n", 
      "Zulu something Female 1/1/200 \n", 
      "Smith something Male 1/1/200 \n", 
      "Whiskey something Male 1/1/200 \n"
      ]
      
  end

  test "Sort players by last_name" do
    result = SortHelper.sort_by_last_name(@player_list)

    assert result == [
      "Smith something Female 1/1/200 \n",
      "Smith something Male 1/1/200 \n",
      "Whiskey something Male 1/1/200 \n",
      "Zulu something Female 1/1/200 \n"
      ]
  end
end
