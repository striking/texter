defmodule Texter.Texter do
  # TODO
  
  # read file  
  def read_file(filename) do
    filename
    |> handle_file
    |> replace_delimeters_with_space 
  end

  def handle_file(filename) do
    case File.read(filename) do
      {:ok, content} -> content
      {:error, error} -> "error #{error}"
    end
  end

  # parse text
  def replace_delimeters_with_space(content) do
    content
      |> String.split("\n", trim: true)
      |> Enum.map(&replace_delimieters/1)
  end


  defp replace_delimieters(content) do
    Regex.replace(~r/[\,\|]/, content, "") |> String.replace("  ", " ")
  end

  # restructure format - Last Name, First Name, Gender, DOB, Favorite Colour
  # sort
  # save new file or append if exists
end
