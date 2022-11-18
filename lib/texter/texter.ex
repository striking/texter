defmodule Texter.Texter do
  # TODO
  # convert date string into Date type
  # implement sort on birthdate
  # implement sort by last name
  # move file functions into file util module
  # move parsing and format functions into a parse util moduile
  # move sorting loginc into sorting module

  def read_file(filename1,filename2, filename3) do

    FileUtils.handle_file() |> Parser.parse_input(file1, file2, file3) |> SortHelper.sort() |> FileUtils.write_file()

    filename
    |> handle_file
    |> String.split(~r/[\n\r\n]/, trim: true)
    # line => player ["player1", "player2"]
    |> Enum.map(&String.split(&1, " ", trim: true))
 #  [[""]]
    |> Enum.map(&convert_player_to_map/1)
    |> Enum.map(&expand_male_or_female/1)
    |> sort_by_gender
    |> Enum.map(&format_output/1)
    |> write_sorted_player_list_to_file 
  end
  
  def sort_by_gender(player_list) do
    Enum.sort_by(player_list, &{&1.gender, &1.last_name})
  end

  def sort_by_last_name(player_list) do
    Enum.sort_by(player_list, &(&1.last_name))
  end
  
  # def convert_date_format(player) do
  #   player
  #   |> String.reverse(player.)
  # end

  # def sort_by_birthdate(player_list) do
  #   Enum.sort_by(player_list, &{&1.gender, &1.last_name})
  # end

  def expand_male_or_female(%{gender: "F"} = player) do
     %{player | gender: "Female"}
  end

  def expand_male_or_female(%{gender: "M"} = player) do
     %{player | gender: "Male"}
  end
  
  def format_output(%{first_name: first_name, last_name: last_name, gender: gender, dob: dob}) do
    #%{first_name: first_name} = player
    # "#{player.last_name} #{player.first_name} #{player.gender} #{player.dob}" <> "\n"
    line_parts = [last_name, " ", first_name, " ", gender, " ", dob, "\n"]
    IO.iodata_to_binary(line_parts)
  end

  def write_sorted_player_list_to_file(player_list) do
    File.write!("../sorted_by_birthdate.txt", player_list, [:append])
  end

  defp convert_player_to_map(player) do
    [last_name, first_name, initial, gender, dob, _favourite_colour] = player
    
    %{last_name: last_name,
      first_name: first_name,
      initial: initial,
      gender: gender,
      dob: format_dob(dob)
    }

  end

  defp handle_file(filename) do
    case File.read(filename) do
      {:ok, content} -> content
      {:error, :enoent} -> 
        IO.puts "Could not find #{filename}"
      _ -> IO.puts "Something really bad has happened..." 
    end
  end



 ############### NOT USED ################################################# 
  defp replace_delimieters(content) do
    Regex.replace(~r/[\,\|]/, content, "") 
    |> String.replace("  ", " ")
    |> String.replace("-", "/")
  end

end
