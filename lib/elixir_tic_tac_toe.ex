defmodule ElixirTicTacToe do
  import ElixirTicTacToe.TurnManagement
  @moduledoc """
  Documentation for ElixirTicTacToe.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirTicTacToe.hello()
      :world

  """
  def hello do
    :world
  end
  #the above boilerplate is just here so I have an example of how the documentation works

  def play() do
    #define the board
    board = %{0 => %{0 => "_", 1 => "_", 2 => "_"},
              1 => %{0 => "_", 1 => "_", 2 => "_"},
              2 => %{0 => "_", 1 => "_", 2 => "_"}}
    #define the player
    current_player = :x

    #call execute_turn
    execute_turn(:playing, current_player, board)
  end

  

end
