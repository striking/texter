defmodule ParserTest do
  use ExUnit.Case
  alias Texter.Parser

  # add error path tests

  describe "expand Male or Female" do
    test "updates a map gender:  F to Female" do
      player = Parser.expand_male_or_female(%{gender: "F"})

      assert player == %{gender: "Female"}
    end

    test "updates a map gender: M to Male" do
      player = Parser.expand_male_or_female(%{gender: "M"})

      assert player == %{gender: "Male"}
    end

    test "Does now change if gender: Male or Female" do
      player = Parser.expand_male_or_female(%{gender: "Female"})

      assert player == %{gender: "Female"}
    end

    test "handles the error" do
      {:error, msg} = Parser.expand_male_or_female("not a map") 
        
      assert msg == "invalid format - expected a map, received: \"not a map\"" 
      end
  end

  test "convert player parts list to map and converts dob format" do
    player = ["OHalloran", "Chris", "M", "M", "9/4/1981", "Green"]

    player = Parser.convert_single_player_to_map(player)

    assert player == %{
             last_name: "OHalloran",
             first_name: "Chris",
             initial: "M",
             gender: "M",
             dob: "1981/4/9"
           }
  end

  test "reformat space delimietered strings" do
    player = [
      "Kournikova Anna F F 6-3-1975 Red", 
      "Hingis Martina M F 4-2-1979 Green",
      "Seles Monica H F 12-2-1973 Black"
    ]

    player = Parser.restructure_space_format_files(player)

    assert player == [
      ["Kournikova", "Anna", "F", "F", "6-3-1975", "Red"], 
      ["Hingis", "Martina", "M", "F", "4-2-1979", "Green"],
      ["Seles", "Monica", "H", "F", "12-2-1973", "Black"]
    ]
  end

  test "reformat comma delimietered strings" do
    player = ["Abercrombie, Neil, Male, Tan, 2/13/1943", 
              "Bishop, Timothy, Male, Yellow, 4/23/1967", 
              "Kelly, Sue, Female, Pink, 7/12/1959"
    ]

    player = Parser.restructure_comma_format_files(player)

    assert player == [
      ["Abercrombie", "Neil", "nil", "Male", "2/13/1943", "Tan"],
      ["Bishop", "Timothy", "nil", "Male", "4/23/1967", "Yellow"],
      ["Kelly", "Sue", "nil", "Female", "7/12/1959", "Pink"]
    ]
  end

  test "reformat pipe delimietered strings" do
    player = [
      "Smith | Steve | D | M | Red | 3-3-1985", 
      "Bonk | Radek | S | M | Green | 6-3-1975", 
      "Bouillon | Francis | G | M | Blue | 6-3-1975"
    ]

    player = Parser.restructure_pipe_format_files(player)

    assert player == [
      ["Smith", "Steve", "D", "M", "3-3-1985", "Red"], 
      ["Bonk", "Radek", "S", "M", "6-3-1975", "Green"], 
      ["Bouillon", "Francis", "G", "M", "6-3-1975", "Blue"]
    ]
  end

  test "change date from day/month/year to year/month/day" do
    dob = Parser.format_dob("9/4/1981")

    assert dob == "1981/4/9"
  end
end
