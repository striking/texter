defmodule Texter.SortHelper do
  alias Texter.Parser
  def sort_by_gender(player_list) do
    player_list
    |> Enum.sort_by(&({&1.gender, &1.last_name}))
    |> Enum.map(&Parser.format_output/1)
  end

  def sort_by_last_name(player_list) do
    player_list
    |> Enum.sort_by(&(&1.last_name))
    |> Enum.map(&Parser.format_output/1)
  end
  def sort_by_birthdate(player_list) do
    player_list
    |> Enum.sort_by(&(&1.dob))
    |> Enum.map(&Parser.format_output/1)
  end
end
