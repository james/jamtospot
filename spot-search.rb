require 'httparty'

module SpotSearch

  API_VERSION = '1'

  class Base
    include HTTParty
    base_uri "http://ws.spotify.com"

    def self.search(string, artist)
      query = {:q => string}
      response = get("/search/#{API_VERSION}/track.json", 
        :query => query, 
        :format => :plain)
      response_j = JSON.parse(response.body)
      #earliest = 2020
      result = ''
      response_j['tracks'].each do |track|
        #released = track['album']['released'].to_i
        #if released < earliest && track['artists'][0]['name'] == artist
        if track['artists'][0]['name'] == artist
          p track['artists'][0]['name']
          #earliest = released
          result = track
          break
        end
      end
      return result['href']
    end
  end
end
      