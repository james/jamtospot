require './spot-search.rb'

class JamToSpot < Sinatra::Base
  enable :sessions 

  register Sinatra::Partial

  ######################## CONFIG ######################
  set :title, 'JamToSpot'
  ######################################################

  get '/' do 
    track = SpotSearch::Base.search('shake your rump')
    erb :index
  end
end