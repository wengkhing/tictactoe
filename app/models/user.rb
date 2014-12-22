class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :won_games, class_name: 'Game', foreign_key: 'winner_id'
  has_many :games_played_as_p1, class_name: 'Game', foreign_key: 'p1_id'
  has_many :games_played_as_p2, class_name: 'Game', foreign_key: 'p2_id'

  def authenticate(pw)
    self.password == pw
  end

  def isHost?(game_id)
    Game.find(game_id).p1.id == self.id
  end

  def isPlayer(game_id)
    game = Game.find(game_id)
    if game.p1.id == self.id
      1
    elsif game.p2.id == self.id
      2
    else
      0
    end
  end

  def turn?(game_id)
    game = Game.find(game_id)
    case isPlayer(game_id)
    when 1
      return game.turn == 1
    when 2
      return game.turn == 2
    else
      return false
    end
  end
end

