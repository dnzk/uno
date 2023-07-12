defmodule UnoWeb.StackHelpers do
  @moduledoc """
  Helper functions for Uno.Game.Stack
  """

  def filter_by_color(stack, color) when color in [:red, :green, :blue, :yellow] do
    stack
    |> Enum.filter(&(&1.color === color))
  end

  def filter_by_number_value(stack) do
    stack
    |> Enum.filter(&is_number(&1.value))
  end

  def filter_by_value(stack, value) do
    stack
    |> Enum.filter(&(&1.value === value))
  end

  def filter_by(stack, options) do
    color = Keyword.get(options, :color, nil)
    value = Keyword.get(options, :value, nil)

    stack =
      case color do
        nil ->
          stack

        color ->
          filter_by_color(stack, color)
      end

    stack =
      case value do
        nil ->
          stack

        value ->
          filter_by_value(stack, value)
      end

    stack
  end
end
