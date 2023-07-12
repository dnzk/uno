defmodule Uno.Game.Stack do
  alias Uno.Game.Card
  @colors [:red, :yellow, :blue, :green]

  def new() do
    generate_number_cards() ++
      generate_skip_cards() ++
      generate_reverse_cards() ++
      generate_draw_2_cards() ++
      generate_wild_cards() ++
      generate_wild_draw_4_cards() ++
      generate_blank_cards()
  end

  def shuffle(stack), do: Enum.shuffle(stack)

  defp generate_number_cards() do
    numbers_1 = for color <- @colors, number <- 0..9, do: Card.new(color, number)
    numbers_2 = for color <- @colors, number <- 1..9, do: Card.new(color, number)
    numbers_1 ++ numbers_2
  end

  defp generate_skip_cards() do
    for color <- @colors, _number <- 0..1, do: Card.new(:skip, color)
  end

  defp generate_reverse_cards() do
    for color <- @colors, _number <- 0..1, do: Card.new(:reverse, color)
  end

  defp generate_draw_2_cards() do
    for color <- @colors, _number <- 0..1, do: Card.new(:draw_2, color)
  end

  defp generate_wild_cards() do
    for _i <- 0..3, do: Card.new(:wild)
  end

  defp generate_wild_draw_4_cards() do
    for _i <- 0..3, do: Card.new(:wild_draw_4)
  end

  defp generate_blank_cards() do
    for _i <- 0..3, do: Card.new(:blank)
  end
end
