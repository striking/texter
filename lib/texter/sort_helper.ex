defmodule Texter.SortHelper do

  @spec sort_by_gender(list(map)) :: list(map)
  def sort_by_gender(player_list) do
    Enum.sort_by(player_list, &{&1.gender, &1.last_name})
  end

  @spec sort_by_last_name(list(map)) :: list(String.t())
  def sort_by_last_name(player_list) do
    Enum.sort_by(player_list, &(&1.last_name))
  end

  @spec sort_by_birthdate(list(map)) :: list(String.t())
  def sort_by_birthdate(player_list) do
    Enum.sort_by(player_list, &(&1.dob))
  end
end
