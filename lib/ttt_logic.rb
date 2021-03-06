module TttLogic
  
  DEFAULT_BOARD = [nil, nil, nil,
                   nil, nil, nil, 
                   nil, nil, nil]

  # def initialize(game)
  #   self = game
  #   @win_checker = TttWinChecker.new
  # end

  ################ FROM TTTGAME ################

  def turn(move)
    unless self.finished?
      unless valid_move?(move.square)
        move.destroy
        self.update(state: 'in_progress', message: "Move not valid. Pick again.")
      else
        self.ttt_moves << move
        place_piece(move.square, move.player[:symbol])
        if self.has_won?(move.player[:symbol], self.board)
          case self.opponent
            when 'user', 'ai'
              self.update(winner_id: self.current_player[:id])
            when 'friend'
          end
          self.update(state: 'finished', message: "#{current_player_display_name} Wins!")
        elsif draw?
          self.update(state: 'finished', is_draw: true, message: "Game is a draw")
        else
          self.update(current_player: switch(current_player))
          self.update(state: 'in_progress', message: "#{current_player_display_name}'s Turn")
        end
      end
    end
  end

  ################ METHODS ################

  def valid_move?(square)
    (0..8).include?(square) && space_available?(square)
  end

  def space_available?(square)
    self.board[square].nil?
  end

  def place_piece(square, piece)
    self.board[square] = piece
  end

  def draw?
    available_spaces.empty?
  end

  def available_spaces
    available = []
    self.board.each_index do |i|
      available << i if self.board[i].nil?
    end
    available
  end

  def switch(player)
    player == self.player1 ? self.player2 : self.player1
  end

  def current_player_display_name
    case self.opponent
      when 'user', 'ai'
        self.current_player_user.username
      when 'friend'
        self.current_player[:symbol].to_s
    end
  end

end