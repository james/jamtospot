class JamToSpot < Sinatra::Base
  enable :sessions 

  register Sinatra::Partial

  ######################## CONFIG ######################
  set :title, 'JamToSpot'
  ######################################################

  get '/' do 
    erb :index
  end
end