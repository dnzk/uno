defmodule Uno.StackTest do
  use ExUnit.Case, async: true
  alias Uno.Game.Stack

  describe "new/0" do
    test "creates 112 cards" do
      assert length(Stack.new()) == 112
    end

    test "creates 19 red number cards" do
      assert Stack.new()
             |> filter_by_color(:red)
             |> filter_by_number_value()
             |> length()
             |> Kernel.===(19)
    end

    test "creates 19 green number cards" do
      assert Stack.new()
             |> filter_by_color(:green)
             |> filter_by_number_value()
             |> length()
             |> Kernel.===(19)
    end

    test "creates 19 yellow number cards" do
      assert Stack.new()
             |> filter_by_color(:yellow)
             |> filter_by_number_value()
             |> length()
             |> Kernel.===(19)
    end

    test "creates 19 blue number cards" do
      assert Stack.new()
             |> filter_by_color(:blue)
             |> filter_by_number_value()
             |> length()
             |> Kernel.===(19)
    end

    @value :skip
    test "creates 8 skip cards" do
      assert Stack.new()
             |> filter_by_value(@value)
             |> length()
             |> Kernel.===(8)
    end

    test "creates 2 red skip cards" do
      assert Stack.new()
             |> filter_by(color: :red, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 green skip cards" do
      assert Stack.new()
             |> filter_by(color: :green, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 yellow skip cards" do
      assert Stack.new()
             |> filter_by(color: :yellow, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 blue skip cards" do
      assert Stack.new()
             |> filter_by(color: :blue, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    @value :reverse
    test "creates 8 reverse cards" do
      assert Stack.new()
             |> filter_by_value(@value)
             |> length()
             |> Kernel.===(8)
    end

    test "creates 2 red reverse cards" do
      assert Stack.new()
             |> filter_by(color: :red, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 green reverse cards" do
      assert Stack.new()
             |> filter_by(color: :green, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 blue reverse cards" do
      assert Stack.new()
             |> filter_by(color: :blue, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 yellow reverse cards" do
      assert Stack.new()
             |> filter_by(color: :yellow, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    @value :draw_2
    test "creates 8 draw_2 cards" do
      assert Stack.new()
             |> filter_by_value(:draw_2)
             |> length()
             |> Kernel.===(8)
    end

    test "creates 2 red draw_2 cards" do
      assert Stack.new()
             |> filter_by(color: :red, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 green draw_2 cards" do
      assert Stack.new()
             |> filter_by(color: :green, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 blue draw_2 cards" do
      assert Stack.new()
             |> filter_by(color: :blue, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 2 yellow draw_2 cards" do
      assert Stack.new()
             |> filter_by(color: :yellow, value: @value)
             |> length()
             |> Kernel.===(2)
    end

    test "creates 4 wild cards" do
      assert Stack.new()
             |> filter_by(value: :wild)
             |> length()
             |> Kernel.===(4)
    end

    test "creates 4 wild draw 4 cards" do
      assert Stack.new()
             |> filter_by(value: :wild_draw_4)
             |> length()
             |> Kernel.===(4)
    end

    test "creates 4 blank cards" do
      assert Stack.new()
             |> filter_by(value: :blank)
             |> length()
             |> Kernel.===(4)
    end
  end

  describe "shuffle/1" do
    test "shuffles the stack" do
      assert Stack.new() !== Stack.shuffle(Stack.new())
    end
  end

  ## Helper functions for stack
  defp filter_by_color(stack, color) when color in [:red, :green, :blue, :yellow] do
    stack
    |> Enum.filter(&(&1.color === color))
  end

  defp filter_by_number_value(stack) do
    stack
    |> Enum.filter(&is_number(&1.value))
  end

  defp filter_by_value(stack, value) do
    stack
    |> Enum.filter(&(&1.value === value))
  end

  defp filter_by(stack, options) do
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
