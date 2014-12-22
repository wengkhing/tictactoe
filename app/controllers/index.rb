set :protection, except: :session_hijacking

get '/' do
  # Look in app/views/index.erb
  redirect '/lobby' if session[:user_id]
  erb :index
end

post '/login' do
  p params[:username]
  p user = User.where(name: params[:username]).first
  unless user == nil
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/lobby'
    end
  end
  redirect '/'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end