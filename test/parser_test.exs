defmodule ParserTest do
  use ExUnit.Case
  alias Texter.Parser


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

  test "convert player parts list to map and converts dob format" do
    player = ["O'Halloran", "Chris", "M", "M", "9/4/1981", "Green"]

    player = Parser.convert_player_to_map(player)

    assert player == %{
      last_name: "O'Halloran",
      first_name: "Chris",
      initial: "M",
      gender: "M",
      dob: "1981/4/9"
    }

  end

  test "reformat space delimietered strings" do
    player = ["O'Halloran Chris M M 9/4/1981 Green", 
              "O'Halloran Roxanne F F 2/1/1978"]
    
    player = Parser.restructure_space_format_files(player)

    assert player == [
        ["O'Halloran", "Chris", "M", "M", "9/4/1981", "Green"], 
        ["O'Halloran", "Roxanne", "F", "F", "2/1/1978"]
        ]  
  end

  test "reformat comma delimietered strings" do
    player = [
          "Abercrombie, Niel, Male, Tan, 2/3/1943", 
          "Bishop, Timothy, Male, Yellow, 4/23/1967"
          ]
    
    player = Parser.restructure_comma_format_files(player)

    assert player == [
        ["Abercrombie", "Niel", "Male", "1943/3/2", "Tan"], 
        ["Bishop", "Timothy", "nil", "Male", "1967/4/23", "Yellow"]
        ]  
  end

  test "reformat pipe delimietered strings" do
    player = [
          "Abercrombie | Niel | Male | Tan 
      2/3/1943", 
          "Bishop, Timothy, Male, Yellow, 4/23/1967"
          ]
    
    player = Parser.restructure_comma_format_files(player)

    assert player == [
        ["Abercrombie", "Niel", "Male", "1943/3/2", "Tan"], 
        ["Bishop", "Timothy", "nil", "Male", "1967/4/23", "Yellow"]
        ]  
  end

  test " change dob from day/month/year to year/month/day" do
    dob = Parser.format_dob("9/4/1981")
    assert dob = "1981/4/9"
  end
end 
