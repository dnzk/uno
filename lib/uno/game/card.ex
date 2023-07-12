defmodule Uno.Game.Card do
  defstruct color: :red, value: nil
  alias __MODULE__

  @colors [:red, :green, :yellow, :blue]
  @values_with_color [:reverse, :skip, :draw_2]
  @values_without_color [:wild, :wild_draw_4, :blank]

  def new(value) when value in @values_without_color do
    %Card{
      color: nil,
      value: value
    }
  end

  def new(_), do: :error

  def new(value, color) when color in @colors and value in @values_with_color do
    %Card{
      color: color,
      value: value
    }
  end

  def new(value, color) when color in @colors and value in 0..9 do
    %Card{
      color: color,
      value: value
    }
  end

  def new(value, color) when color in @colors do
    %Card{
      color: color,
      value: value
    }
  end

  def new(_, _), do: :error
end
