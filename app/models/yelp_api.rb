class YelpApi < ApplicationRecord
   

    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_LIMIT = 10

    API_KEY = ENV["YELP_API_KEY"]

    def self.search(term, location = "city")
        url = "#{API_HOST}#{SEARCH_PATH}"
        params = {
        term: term,
        location: location,
        limit: SEARCH_LIMIT
        }
        response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
        JSON.parse(response)
    end


    def self.api_business(business_id)
        url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
        response = HTTP.auth("Bearer #{ENV['API_KEY']}").get(url)
        JSON.response.parse
      end

    def self.api_hash_converter(hash)
        @rest_hash = {}
        @rest_hash[:name] = hash["name"]
        @rest_hash[:city] = hash["location"]["city"]
        @rest_hash[:state] = hash["location"]["state"]
        @rest_hash[:yelp_id] = hash["id"]
        @rest_hash
    end

    def self.loc_hash_converter(hash)
        @location_array = hash["location"]
    end

    def self.make_brewery(brewery)
        @rest_hash = YelpApi.api_hash_converter(brewery)
        @loc_hash = YelpApi.loc_hash_converter(brewery)
        if @rest_hash[:name] && !Brewery.find_by_yelp_id(@rest_hash[:business_id])
          brewery = Brewery.create(@rest_hash)            
           @loc_hash.each do |hash|
            breweries.location << Brewery.create_with(hash).find_or_create_by(name: hash["name"])      
            end
        end
    end      
end