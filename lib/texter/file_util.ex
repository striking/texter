defmodule Texter.FileUtil do
  alias Texter.SortHelper

  def handle_file(file) do
    case File.read(file) do
      {:ok, content} -> content
      {:error, :enoent} -> 
        IO.puts "Could not find #{file}"
      _ -> IO.puts "Something really bad has happened..." 
    end
  end
  def write_sorted_player_list_to_file(player_list) do
    File.write!("../sorted_by_gender.txt", SortHelper.sort_by_gender(player_list), [:append])
    File.write!("../sorted_by_last_name.txt", SortHelper.sort_by_gender(player_list), [:append])
    File.write!("../sorted_by_birthdate.txt", SortHelper.sort_by_gender(player_list), [:append])
  end
end
