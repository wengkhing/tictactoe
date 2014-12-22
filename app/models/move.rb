class Move < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :game

  def self.find_piece(game_id, x_pos, y_pos)
    move = Move.where("game_id = ? AND x = ? AND y= ?", game_id, x_pos, y_pos).first
    if move == nil
      return 0
    else
      return move.played_by
    end
  end
end
