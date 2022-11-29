defmodule Texter.Parser do
  @spec parse_txt_file({:ok, String.t()} | {:error, String.t()}) ::
          {:ok, list(map)} | {:error, String.t()}
  def parse_txt_file({:ok, content}) do
    player_list =
      content
      |> String.split(~r/[\n\r\n]/, trim: true)
      |> check_format_and_standardise 
      |> convert_player_to_map
      |> expand_male_or_female

    {:ok, player_list}
  end

  def parse_txt_file(error), do: error
  
  def expand_male_or_female(player_list) when is_list(player_list) do
    Enum.map(player_list, &expand_male_or_female/1)
  end
  
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

  def expand_male_or_female(player) do 
    {:error, "invalid format - expected a map, received: #{inspect(player)}"}
  end

  @spec format_player_output(map) :: String.t()
  def format_player_output(%{
        first_name: first_name,
        last_name: last_name,
        gender: gender,
        dob: dob
      }) do
    "#{last_name} #{first_name} #{gender} #{dob} \n"
    # line_parts = [last_name, " ", first_name, " ", gender, " ", dob, "\n"]
    # IO.iodata_to_binary(line_parts)
  end


  @spec format_player_output(list(list(String.t()))) :: list(map)
  def format_player_output(player_list) when is_list(player_list) do
    Enum.map(player_list, &format_player_output/1)
  end

  @spec convert_single_player_to_map(list(String.t())) :: map()
  def convert_single_player_to_map(player) do
    [last_name, first_name, initial, gender, dob, _favourite_colour] = player

    %{
      last_name: last_name,
      first_name: first_name,
      initial: initial,
      gender: gender,
      dob: format_dob(dob)
    }
  end

  # @spec convert_player_to_map(list(String.t())) :: list(map)
  def convert_player_to_map(player_list) do
    Enum.map(player_list, &convert_single_player_to_map/1)
  end

  @spec check_format_and_standardise(list(String.t())) :: fun()
  defp check_format_and_standardise(player_list) when is_list(player_list) do
    cond do
      String.match?(List.first(player_list), ~r/\|/) ->
        restructure_pipe_format_files(player_list)

      String.match?(List.first(player_list), ~r/\,/) ->
        restructure_comma_format_files(player_list)

      String.match?(List.first(player_list), " ") ->
        restructure_space_format_files(player_list)

      true -> "error, no matching format in: #{inspect(player_list)}"
    end
  end

  defp check_format_and_standardise({:error, msg}), do: msg

  @spec restructure_space_format_files(list(String.t())) :: list()
  def restructure_space_format_files(player_list) when is_list(player_list) do
    player_list
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  def restructure_space_format_files(error), do: error

  @spec restructure_comma_format_files(list(String.t())) :: fun()
  def restructure_comma_format_files(player_list) when is_list(player_list) do
    player_list
    |> Enum.map(&String.split(&1, ", ", trim: true))
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

  @spec format_dob(list()) :: String.t()
  def format_dob(dob) do
    [day, month, year] =
      dob
      |> String.split(~r/[\-\/]/, trim: true)

    "#{year}/#{month}/#{day}"
  end
end
