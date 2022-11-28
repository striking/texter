defmodule SortHelperTest do
  use ExUnit.Case
  alias Texter.SortHelper

  describe "sort players" do
    setup do
    player_list = [
      %{gender: "Female", last_name: "Smith", first_name: "something", dob: "1/1/200"},
      %{gender: "Male", last_name: "Smith", first_name: "something", dob: "1/1/200"},
      %{gender: "Female", last_name: "Zulu", first_name: "something", dob: "1/1/200"},
      %{gender: "Male", last_name: "Whiskey", first_name: "something", dob: "1/1/200"}
    ]

    {:ok, player_list: player_list}
    end

    test "Sort by Gender", %{player_list: player_list} do
      result = SortHelper.sort_by_gender(player_list)

      assert result == [
        %{gender: "Female", last_name: "Smith", first_name: "something", dob: "1/1/200"},
        %{gender: "Female", last_name: "Zulu", first_name: "something", dob: "1/1/200"},
        %{gender: "Male", last_name: "Smith", first_name: "something", dob: "1/1/200"},
        %{gender: "Male", last_name: "Whiskey", first_name: "something", dob: "1/1/200"}
      ]
    end

    test "Sort players by last_name", %{player_list: player_list} do
      result = SortHelper.sort_by_last_name(player_list)

      assert result == [
        %{gender: "Female", last_name: "Smith", first_name: "something", dob: "1/1/200"},
        %{gender: "Male", last_name: "Smith", first_name: "something", dob: "1/1/200"},
        %{gender: "Male", last_name: "Whiskey", first_name: "something", dob: "1/1/200"}, 
        %{gender: "Female", last_name: "Zulu", first_name: "something", dob: "1/1/200"}
      ]
    end
  end
end
