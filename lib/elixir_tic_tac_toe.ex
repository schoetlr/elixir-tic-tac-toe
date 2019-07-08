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
        print_board(board)
        IO.puts "Game Over"
        IO.puts "Player #{player} wins"
      :playing -> 
        #print the board
        print_board(board)
        
        #get move
        #validate move
        move = manage_move(player, board)

        #update board
        board = update_board(move, player, board)

        #check for winner and determine status
        status = game_status(board)
        
        #determine player
        player = if status == :playing do
          switch_player(player)
        else
          player
        end

        execute_turn(status, player, board)

    end
  end

  def game_status(board) do 
    if game_over?(board) do
      :game_over
    else
      :playing
    end
  end

  def game_over?(board) do 
    horizontal_win?(board) || vertical_win?(board) || diagonal_win?(board)
  end

  def horizontal_win?(board) do 
    Enum.any?(board, fn {k, row} -> 
      Enum.all?(row, fn{k, val} ->
        val == :x
      end) || Enum.all?(row, fn {k, val} ->
        val == :o
      end) 
    end)
  end

  def vertical_win?(board) do 
    #thought about looping to do this but it got pretty convoluted so stuck to with this ?procedural? solution

    cond do 
      board[0][0] == :x && board[1][0] == :x && board[2][0] == :x ->
        true
      board[0][1] == :x && board[1][1] == :x && board[2][1] == :x ->
        true
      board[0][2] == :x && board[1][2] == :x && board[2][2] == :x ->
        true
      board[0][0] == :o && board[1][0] == :o && board[2][0] == :o ->
        true
      board[0][1] == :o && board[1][1] == :o && board[2][1] == :o ->
        true
      board[0][2] == :o && board[1][2] == :o && board[2][2] == :o ->
        true
      true ->
        false
    end
  end

  def diagonal_win?(board) do 
    cond do 
      board[0][0] == :x && board[1][1] == :x && board[2][2] == :x ->
        true
      board[0][2] == :x && board[1][1] == :x && board[2][0] == :x ->
        true
      board[0][0] == :o && board[1][1] == :o && board[2][2] == :o ->
        true
      board[0][2] == :o && board[1][1] == :o && board[2][0] == :o ->
        true
      true ->
        false
    end
  end

  def switch_player(player) do 
    player_swapper = %{:x => :o, :o => :x}
    player = player_swapper[player]

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
    move = get_move()

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

  def valid_move?(move, board) do 
    {row, col} = move
    current_pos = board[row][col]

    cond do 
      row > 2 || col > 2 ->
        false
      row < 0 || col < 0 ->
        false
      current_pos != "_" ->
        false
      true -> true
    end
  end

  def update_board(move, player, board) do 
    {row, col} = move

    put_in(board, [row, col], player)
  end

end
