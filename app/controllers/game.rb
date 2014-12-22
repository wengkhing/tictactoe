get '/lobby' do
  @games = Game.all
  erb :lobby
end

get '/game/play/:game_id' do
  @game = Game.find(params[:game_id])
  @user = User.find(session[:user_id])
  @player = @user.isPlayer(@game.id)
  moves = Move.where(game_id: @game.id)
  if moves == []
    @no_moves = true
  else
    @no_moves = false
  end
  erb :game
end

get '/game/play/:game_id/join' do
  game = Game.find(params[:game_id])
  game.update(p2_id: session[:user_id], status: 1)
  redirect "/game/play/#{game.id}"
end

get '/game/play/:game_id/move' do
  game = Game.find(params[:game_id])
  Move.create(game_id: params[:game_id], played_by: params[:played_by], x: params[:x], y: params[:y])
  case params[:played_by].to_i
  when 1
    game.update(turn: 2)
  when 2
    game.update(turn: 1)
  end

  if game.has_win?(1)
    game.update(winner_id: game.p1.id, status: 2)
    redirect "/game/play/#{game.id}/result"
  end

  if game.has_win?(2)
    game.update(winner_id: game.p2.id, status: 2)
    redirect "/game/play/#{game.id}/result"
  end

  if game.no_move_left?
    game.update(status: 2)
  end

  redirect "/game/play/#{params[:game_id]}"
end

get '/game/play/:game_id/result' do
  @game = Game.find(params[:game_id])
  erb :result
end

get '/game/create' do
  game = Game.create(p1_id: session[:user_id])
  redirect "/game/play/#{game.id}"
end