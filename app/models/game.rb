class Game < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :p1, class_name: 'User', foreign_key: 'p1_id'
  belongs_to :p2, class_name: 'User', foreign_key: 'p2_id'
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  has_many :moves

  def status_to_s
    case status
    when 0
      "Waiting"
    when 1
      "Playing"
    when 2
      "Completed"
    end
  end

  def has_win?(player)
    # Check if there are any horizontal or vertical win
    (1..3).each do |i|
      if Move.where(game_id: id, played_by: player, x: i).count == 3
        return true
      end

      if Move.where(game_id: id, played_by: player, y: i).count == 3
        return true
      end
    end

    #Check diagonal no. 1 win
    if Move.where(game_id: id, played_by: player).where("x = y").count == 3
      return true
    end

    #Check diagonal no. 2 win
    if Move.where(game_id: id, played_by: player).where("x + y = 4").count == 3
      return true
    end

    return false
  end

  def no_move_left?
    Move.where(game_id: id).count == 9
  end
end
