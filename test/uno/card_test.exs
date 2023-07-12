defmodule Uno.CardTest do
  use ExUnit.Case, async: true
  alias Uno.Game.Card
  use ExUnitProperties

  describe "new/1" do
    property "returns error for invalid values" do
      check all(value <- stream_invalid_colorless_card_values()) do
        assert Card.new(value) === :error
      end
    end

    property "creates card for valid values" do
      check all(value <- StreamData.one_of([:wild, :wild_draw_4, :blank])) do
        assert Card.new(value) === %Card{color: nil, value: value}
      end
    end
  end

  describe "new/2" do
    property "returns error for invalid values" do
      check all(
              value <- stream_invalid_color_card_values(),
              color <- stream_invalid_card_colors()
            ) do
        assert Card.new(value, color) === :error
      end
    end

    property "creates card for valid values" do
      check all(
              value <- stream_valid_color_card_values(),
              color <- stream_valid_card_colors()
            ) do
        assert Card.new(value, color) === %Card{color: color, value: value}
      end
    end
  end

  defp stream_invalid_colorless_card_values() do
    StreamData.filter(StreamData.term(), fn
      :wild -> false
      :wild_draw_4 -> false
      :blank -> false
      _ -> true
    end)
  end

  defp stream_invalid_color_card_values() do
    StreamData.filter(StreamData.term(), fn
      :reverse -> false
      :skip -> false
      :draw_2 -> false
      0..9 -> false
      _ -> true
    end)
  end

  defp stream_invalid_card_colors() do
    StreamData.filter(StreamData.atom(:alphanumeric), fn
      :red -> false
      :green -> false
      :yellow -> false
      :blue -> false
      _ -> true
    end)
  end

  defp stream_valid_color_card_values() do
    StreamData.one_of([:reverse, :skip, :draw_2, StreamData.integer(0..9)])
  end

  defp stream_valid_card_colors() do
    StreamData.one_of([:red, :green, :yellow, :blue])
  end
end
