defmodule ElixirTicTacToe.TurnManagement do
  import ElixirTicTacToe.EndGameLogic

  def execute_turn(status, player, board) do 
    #if status is over display a game over message and stop recursion
    case status do 
      :game_over -> 
        #determine winner
        print_board(board)

        IO.puts "Game Over"
        if board_full?(board) do 
          IO.puts "Catz Game"
        else
          IO.puts "Player #{player} wins"
        end
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

  def switch_player(player) do 
    player_swapper = %{:x => :o, :o => :x}
    player_swapper[player]
  end

  def print_board(board) do 
    print_line = fn {_key, row} ->
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