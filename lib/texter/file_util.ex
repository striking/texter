defmodule Texter.FileUtil do
  require Logger
  alias Texter.Parser
  alias Texter.SortHelper

  @spec handle_file(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def handle_file(filename) do
    case File.read(Path.join(File.cwd!(), "/priv/" <> filename)) do
      {:ok, file_data} ->
        {:ok, file_data}

      {:error, :enoent} ->
        msg = "could not find #{filename}"
        Logger.info(msg)
        {:error, msg}

      err ->
        msg = "Something unexpected has happened with error, #{inspect(err)}"
        Logger.info(msg)
        {:error, msg}
    end
  end

  @spec write_sorted_player_list_to_file({:ok, list(String.t())}) :: {:ok, boolean}
  def write_sorted_player_list_to_file({:ok, player_list}) do
    File.write!(
      "../sorted_by_gender.txt",
      player_list 
      |> SortHelper.sort_by_gender() 
      |> Parser.format_player_output(), 
      [:append]
    )

    File.write!(
      "../sorted_by_last_name.txt", 
      player_list 
      |> SortHelper.sort_by_gender()
      |> Parser.format_player_output(), 
      [:append]
    )

    File.write!(
      "../sorted_by_birthdate.txt", 
      player_list
      |> SortHelper.sort_by_gender()
      |> Parser.format_player_output(), 
      [:append]
    )

    {:ok, true}
  end

  def write_sorted_player_list_to_file(error), do: error
end
