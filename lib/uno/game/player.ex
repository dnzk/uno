defmodule Uno.Game.Player do
  defstruct name: "", hand: []
  alias __MODULE__

  def new(name, hand) when is_binary(name) and is_list(hand) do
    %Player{name: name, hand: hand}
  end

  def new(_, _), do: :error
end
