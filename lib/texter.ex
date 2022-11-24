defmodule Texter do
  alias Texter.FileUtil
  alias Texter.Parser

  @spec read_files_and_save_single_output(list(String.t())) :: iodata()
  defp read_files_and_save_single_output(filename) do
    filename
    |> FileUtil.handle_file
    |> Parser.parse_txt_file
    |> FileUtil.write_sorted_player_list_to_file 
  end

  @spec convert_files() :: :ok
  def convert_files do
   Enum.each(["space.txt", "pipe.txt", "comma.txt"], &read_files_and_save_single_output/1) 
  end
end
