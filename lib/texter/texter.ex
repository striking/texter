defmodule Texter.Texter do
  alias Texter.FileUtil
  alias Texter.Parser

  def read_files_and_save_single_output(file) do
    file
    |> FileUtil.handle_file
    |> Parser.parse_txt_file
    |> FileUtil.write_sorted_player_list_to_file 
  end
  
  def read_files_and_save_single_output(file1, file2) do
   [file1, file2] |> Enum.each(&read_files_and_save_single_output/1) 
  end

  def read_files_and_save_single_output(file1, file2, file3) do
   [file1, file2, file3] |> Enum.each(&read_files_and_save_single_output/1) 
  end
end
