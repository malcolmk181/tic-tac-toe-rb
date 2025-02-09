# Helper Method
def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
end
  
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [0,4,8]
]
  
def won?(board)
    WIN_COMBINATIONS.each do |combo|
        if (board[combo[0]] == "X" || board[combo[0]] == "O") && board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
            return combo
        end
    end
    return false
end
  
def full?(board)
    !board.find { |square| square != "X" && square != "O" }
end
  
def draw?(board)
    !won?(board) && full?(board)
end
  
def over?(board)
    draw?(board) || won?(board)
end
  
# I used a local variable because I wanted to avoid calling the won? function twice
def winner(board)
    (result = won?(board)) ? board[result[0]] : nil
end

def turn_count(board)
    turns = 0
    board.each do |square|
        if square == "X" || square == "O"
            turns += 1
        end
    end
    return turns
end

def current_player(board)
    turn_count(board).even? ? "X" : "O"
end

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
  
def input_to_index(user_input)
    user_input.to_i - 1
end
  
def move(board, index, current_player)
    board[index] = current_player
end
  
def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end
  
def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end
  
# Define your play method below
def play(board)
    while !over?(board)
        turn(board)
    end

    if won?(board)
        # congratulate winner
        puts "Congratulations #{winner(board)}!"
    else
        # tell players it has been a draw
        puts "Cat's Game!"
    end
end