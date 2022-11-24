defmodule Texter.FileUtil do
  require Logger
  alias Texter.SortHelper
  

@spec handle_file(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def handle_file(filename) do
    case File.read(Path.join(File.cwd!(), "/priv/" <> filename)) do
      {:ok, content} -> {:ok, content}
      {:error, :enoent} -> 
        msg = "could not fine #{filename}" 
        Logger.info(msg)
      {:error, msg}
      err ->
        msg = "Something unexpected has happened with error, #{inspect(err)}"
        Logger.info(msg)
      {:error, msg}
    end
  end

  @spec write_sorted_player_list_to_file({:ok, list(String.t())}) :: fun() 
  def write_sorted_player_list_to_file({:ok, player_list}) do
    File.write!("../sorted_by_gender.txt", SortHelper.sort_by_gender(player_list), [:append])
    File.write!("../sorted_by_last_name.txt", SortHelper.sort_by_gender(player_list), [:append])
    File.write!("../sorted_by_birthdate.txt", SortHelper.sort_by_gender(player_list), [:append])
  end

  def write_sorted_player_list_to_file(error), do: error
end
