defmodule ElixirTicTacToe do
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

  def execute_turn(status, player, board) do 
    #if status is over display a game over message and stop recursion
    case status do 
      :game_over -> 
        #determine winner
        IO.puts "Game Over"
      :playing -> 
        IO.puts "Playing"
        #get move
        #validate move
        #update board
        #check for winner and determine status
        status = :playing
        player = :o 
        #determine player

        execute_turn(status, player, board)

    end

    #if status is ongoing then take another turn with updated state
  end
end
