defmodule Uno.Game do
  defstruct draw_pile: [], players: [], discard_pile: []
  alias Uno.Game.Stack
  alias __MODULE__

  def start(players) when length(players) > 1 and length(players) <= 10 do
    {:ok,
     Stack.new()
     |> Stack.shuffle()
     |> split_to_players(players)}
  end

  def start(_), do: {:error, "Players count invalid"}

  defp split_to_players(stack, players) do
    {for_players, remains} = slice_stack(stack, length(players))
    %Game{draw_pile: remains, players: slice_for_players(for_players, players)}
  end

  defp slice_stack(stack, players_count) do
    for_players = Enum.slice(stack, 0, players_count * 7)
    remains = Enum.slice(stack, players_count, length(stack))
    {for_players, remains}
  end

  defp slice_for_players(for_players, players) do
    slice_for_players(for_players, players, [])
  end

  defp slice_for_players(for_players, [player | rest], handed_players) do
    handed_players = [%{player | hand: Enum.take(for_players, 7)}] ++ handed_players
    slice_for_players(Enum.slice(for_players, 7..length(for_players)), rest, handed_players)
  end

  defp slice_for_players([], [], players), do: players
end
