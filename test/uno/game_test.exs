defmodule Uno.GameTest do
  use Uno.DataCase, async: true
  use ExUnitProperties
  alias Uno.Game

  describe "start/1" do
    property "gives each players 7 cards" do
      check all(players <- stream_players()) do
        {:ok, %{players: game_players}} = Game.start(players)
        for p <- game_players, do: assert(length(p.hand) === 7)
      end
    end

    property "always has cards in draw pile" do
      check all(players <- stream_players()) do
        {:ok, %{draw_pile: draw_pile}} = Game.start(players)
        assert length(draw_pile) > 0
      end
    end

    property "starts with zero discard pile" do
      check all(players <- stream_players()) do
        {:ok, %{discard_pile: discard_pile}} = Game.start(players)
        assert length(discard_pile) === 0
      end
    end

    property "returns error when players count is invalid" do
      check all(
              players <-
                StreamData.one_of([
                  stream_undercount_players(),
                  stream_overcount_players()
                ])
            ) do
        assert {:error, _} = Game.start(players)
      end
    end
  end

  defp stream_players() do
    StreamData.list_of(
      StreamData.fixed_map(%{
        name: StreamData.string(:utf8),
        hand: StreamData.fixed_list([])
      }),
      min_length: 2,
      max_length: 10
    )
  end

  defp stream_undercount_players() do
    StreamData.list_of(
      StreamData.fixed_map(%{
        name: StreamData.string(:utf8),
        hand: StreamData.fixed_list([])
      }),
      min_length: 0,
      max_length: 1
    )
  end

  defp stream_overcount_players() do
    StreamData.list_of(
      StreamData.fixed_map(%{
        name: StreamData.string(:utf8),
        hand: StreamData.fixed_list([])
      }),
      min_length: 11
    )
  end
end
