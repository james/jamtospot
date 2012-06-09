require 'httparty'

module SpotSearch

  API_VERSION = '1'

  class Base
    include HTTParty
    base_uri "http://ws.spotify.com"

    def self.search(string)
      query = {:q => string}
      response = get("/search/#{API_VERSION}/track.json", 
        :query => query, 
        :format => :plain)
      response_j = JSON.parse(response.body)
      earliest = 2020
      result = ''
      response_j['tracks'].each do |track|
        if track['album']['released'].to_i < earliest
          earliest = track['album']['released'].to_i
          result = track
        end
      end
      p result['href']
    end
  end
end
      