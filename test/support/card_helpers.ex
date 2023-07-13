defmodule UnoWeb.CardHelpers do
  @moduledoc """
  Helper functions for Uno.Game.Card
  """

  def stream_color_card() do
    StreamData.fixed_map(%{
      color: StreamData.one_of([:red, :green, :yellow, :blue]),
      value: StreamData.one_of([:reverse, :skip, :draw_2, StreamData.integer(0..9)])
    })
  end

  def stream_colorless_card() do
    StreamData.fixed_map(%{
      color: nil,
      value: StreamData.one_of([:wild, :wild_draw_4, :blank])
    })
  end

  def stream_any_card() do
    StreamData.one_of([stream_color_card(), stream_colorless_card()])
  end
end
