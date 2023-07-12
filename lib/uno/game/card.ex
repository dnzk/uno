defmodule Uno.Game.Card do
  defstruct color: :red, value: ""
  alias __MODULE__

  def new(:reverse, color) do
    %Card{
      color: color,
      value: :reverse
    }
  end

  def new(:skip, color) do
    %Card{
      color: color,
      value: :skip
    }
  end

  def new(:draw_2, color) do
    %Card{
      color: color,
      value: :draw_2
    }
  end

  def new(color, value) do
    %Card{
      color: color,
      value: value
    }
  end

  def new(:wild) do
    %Card{
      color: nil,
      value: :wild
    }
  end

  def new(:wild_draw_4) do
    %Card{
      color: nil,
      value: :wild_draw_4
    }
  end

  def new(:blank) do
    %Card{
      color: nil,
      value: :blank
    }
  end
end
