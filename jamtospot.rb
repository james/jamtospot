require './spot-search.rb'

class JamToSpot < Sinatra::Base
  enable :sessions 

  register Sinatra::Partial

  ######################## CONFIG ######################
  set :title, 'JamToSpot'
  ######################################################

  get '/' do 
    erb :index
  end

  post '/' do
    redirect "/playlist/#{params[:username]}"
  end

  get '/playlist/:username' do
    jammed = Jammed.new
    @jam_count = 0
    jam_titles = []
    jam_artists = []
    following = jammed.following(params[:username]).each do |followee|
      jams = jammed.jams(followee['name'])
      @jam_count += jams.length
      jams.each do |j|
        jam_titles << j['title']
        jam_artists << j['artist']
      end
    end

    @data = []

    jam_titles.each_with_index do |track, i|
      artist = jam_artists[i]
      @data << [artist, track, SpotSearch::Base.search(track, artist)]
    end
    p @data

    erb :result
  end
end