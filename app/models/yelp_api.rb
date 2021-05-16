class YelpApi < ApplicationRecord
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/" 
    SEARCH_LIMIT = 10

    API_KEY = ENV["YELP_API_KEY"]

    def self.search(term, location)
        url = "#{API_HOST}#{SEARCH_PATH}"
        params = {
        term: term,
        location: location,
        limit: SEARCH_LIMIT
        }
        response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
        JSON.parse(response)
    end

end
