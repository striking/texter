defmodule Texter.Texter do
  # TODO
  
  # read file  
  def read_file(filename) do
    filename
    |> handle_file
    |> parse_text 
  end

  def handle_file(filename) do
    case File.read(filename) do
      {:ok, content} -> content
      {:error, error} -> "error #{error}"
    end
  end

  def parse_text(content) do
    content
      |> String.split("\n", trim: true)
  end
  # parse text
  # sort
  # print new file or append if exists
end
