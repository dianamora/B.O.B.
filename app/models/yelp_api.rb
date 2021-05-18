class YelpApi < ApplicationRecord
    has_many :breweries 

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


    def self.api_business(yelp_id)
        url = "#{API_HOST}#{BUSINESS_PATH}#{yelp_id}"
        response = HTTP.auth("Bearer #{ENV['API_KEY']}").get(url)
        JSON.response.parse
      end

    def self.api_hash_converter(hash)
        @rest_hash = {}
        @rest_hash[:name] = hash["name"]
        @rest_hash[:display_phone] = hash["display_phone"]
        @rest_hash[:rating] = hash["rating"]
        @rest_hash[:url] = hash["url"]
        @rest_hash[:address] = hash["location"]["address1"]
        @rest_hash[:city] = hash["location"]["city"]
        @rest_hash[:state] = hash["location"]["state"]
        @rest_hash[:zip_code] = hash["location"]["zip_code"]
        @rest_hash[:yelp_id] = hash["id"]
        @rest_hash[:image_url] = hash["image_url"]
        @rest_hash
    end

    def self.make_brewery(brewery)
        @rest_hash = YelpApi.yelp_hash_converter(brewery)
        if @rest_hash[:name] && !Brewery.find_by_yelp_id(@rest_hash[:yelp_id])
          brewery = Brewery.create(@rest_hash)            
            render brewery
        else
            render json: { message: "Sorry brewery not found"}             
    
        end
    end      
end