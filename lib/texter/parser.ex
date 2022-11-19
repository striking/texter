defmodule Texter.Parser do

  def parse_txt_file(content) do
   content
    |> String.split(~r/[\n\r\n]/, trim: true) # split by new lines
    |> check_format_and_standardise
    |> Enum.map(&convert_player_to_map/1)
    |> Enum.map(&expand_male_or_female/1)
  end

  def expand_male_or_female(%{gender: "F"} = player) do
     %{player | gender: "Female"}
  end

  def expand_male_or_female(%{gender: "M"} = player) do
     %{player | gender: "Male"}
  end
  
  def expand_male_or_female(%{gender: _gender} = player) do
     player
  end
  
  def format_output(%{first_name: first_name, last_name: last_name, gender: gender, dob: dob}) do
    "#{last_name} #{first_name} #{gender} #{dob} \n"
    # line_parts = [last_name, " ", first_name, " ", gender, " ", dob, "\n"]
    # IO.iodata_to_binary(line_parts)
  end

  def convert_player_to_map(player) do
    [last_name, first_name, initial, gender, dob, _favourite_colour] = player
    %{last_name: last_name,
      first_name: first_name,
      initial: initial,
      gender: gender,
      dob: format_dob(dob)
    }
  end
  
  defp check_format_and_standardise(player_list) do
    cond do
      String.match?(List.first(player_list), ~r/\|/) -> 
        restructure_pipe_format_files(player_list) 
      String.match?(List.first(player_list), ~r/\,/) -> 
        restructure_comma_format_files(player_list) 
      true -> 
        restructure_space_format_files(player_list)  
    end
  end

  defp restructure_space_format_files(player_list)do
    player_list
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  defp restructure_comma_format_files(player_list) do
    player_list
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.map(&Enum.slide(&1, 3, -1))
    |> Enum.map(&List.insert_at(&1, 2, "nil"))
  end
  
  defp restructure_pipe_format_files(player_list) do
    player_list
    |> Enum.map(&String.split(&1, " | ", trim: true))
    |> Enum.map(&Enum.slide(&1, 4, -1))
  end
  
    defp format_dob(dob) do
    [day, month, year] = 
      dob 
      |> String.split(~r/[\-\/]/, trim: true)

     "#{year}/#{month}/#{day}"
  end
end
