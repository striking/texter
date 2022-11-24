defmodule Texter.Parser do

  @spec parse_txt_file({:ok, String.t()} | {:error, String.t()}) :: {:ok, list(map)} | {:error, String.t()}
  def parse_txt_file({:ok, content}) do
   player_list = content
    |> String.split(~r/[\n\r\n]/, trim: true) # split by new lines
    |> check_format_and_standardise
    |> Enum.map(&convert_player_to_map/1)
    |> Enum.map(&expand_male_or_female/1)
    {:ok, player_list}
  end

  def parse_txt_file(error), do: error

  @spec expand_male_or_female(map) :: map 
  def expand_male_or_female(%{gender: "F"} = player) do
     %{player | gender: "Female"}
  end

  def expand_male_or_female(%{gender: "M"} = player) do
     %{player | gender: "Male"}
  end
  
  def expand_male_or_female(%{gender: _gender} = player) do
     player
  end
 
  @spec format_output(map) :: String.t()
  def format_output(%{first_name: first_name, last_name: last_name, gender: gender, dob: dob}) do
    "#{last_name} #{first_name} #{gender} #{dob} \n"
    # line_parts = [last_name, " ", first_name, " ", gender, " ", dob, "\n"]
    # IO.iodata_to_binary(line_parts)
  end

  @spec convert_player_to_map(list(String.t())) :: map
  def convert_player_to_map(player) do
    [last_name, first_name, initial, gender, dob, _favourite_colour] = player
    %{last_name: last_name,
      first_name: first_name,
      initial: initial,
      gender: gender,
      dob: format_dob(dob)
    }
  end
  
  @spec check_format_and_standardise(list(String.t())) :: fun()
  def check_format_and_standardise(player_list) when is_list(player_list) do
    cond do
      String.match?(List.first(player_list), ~r/\|/) -> 
        restructure_pipe_format_files(player_list) 
      String.match?(List.first(player_list), ~r/\,/) -> 
        restructure_comma_format_files(player_list) 
      true -> 
        restructure_space_format_files(player_list)  
    end
  end

  def check_format_and_standardise(error), do: error

  @spec restructure_space_format_files(list(String.t())) :: list()
  def restructure_space_format_files(player_list) when is_list(player_list) do
    player_list
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  def restructure_space_format_files(error), do: error

  @spec restructure_comma_format_files(list(String.t())) :: fun()
  def restructure_comma_format_files(player_list) when is_list(player_list) do
    player_list
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.map(&Enum.slide(&1, 3, -1))
    |> Enum.map(&List.insert_at(&1, 2, "nil"))
  end
  
  def restructure_comma_format_files(error), do: error

  @spec restructure_pipe_format_files(list(String.t())) :: fun()
  def restructure_pipe_format_files(player_list) when is_list(player_list) do
    player_list
    |> Enum.map(&String.split(&1, " | ", trim: true))
    |> Enum.map(&Enum.slide(&1, 4, -1))
  end
  
  def restructure_pipe_format_files(error), do: error

  @spec format_dob(list(String.t())) :: String.t() 
  def format_dob(dob) do
    [day, month, year] = dob 
    |> String.split(~r/[\-\/]/, trim: true)

    "#{year}/#{month}/#{day}"
  end
end
