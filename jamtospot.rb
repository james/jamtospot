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
    redirect "/result/#{params[:username]}"
  end

  get '/result/:username' do
    jammed = Jammed.new
    jams = jammed.jams(params[:username])
    @jam_count = jams.length
    jam_titles = []
    jam_artists = []
    jams.each do |j|
      jam_titles << j['title']
      jam_artists << j['artist']
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