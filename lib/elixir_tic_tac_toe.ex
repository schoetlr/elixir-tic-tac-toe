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
        #print the board
        print_board(board)
        #get move
        #validate move
        manage_move(player, board)
        #update board
        #check for winner and determine status
        status = :playing
         
        #determine player
        player = :o

        execute_turn(status, player, board)

    end
  end

  def print_board(board) do 
      print_line = fn {key, row} ->
        output = "#{row[0]} #{row[1]} #{row[2]}"
        IO.puts output
      end

      Enum.each(board, print_line)
  end

  #this gets and validates a move, if move is invalid then retry
  def manage_move(player, board) do
    IO.puts "Player #{player}'s turn"
    move = get_move

    if valid_move?(move, board) do 
      move
    else
      manage_move(player, board)
    end
  end

  #returns tuple of row, col
  def get_move do
    row = IO.gets("Enter the row: 0-2 ") |> String.trim_trailing |> String.to_integer
    col = IO.gets("Enter the col: 0-2 ") |> String.trim_trailing |> String.to_integer

    {row, col}
  end

  def valid_move?(player, board) do 
    true
  end

end
