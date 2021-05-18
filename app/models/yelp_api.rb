class YelpApi < ApplicationRecord
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search?"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_LIMIT = 10

    # API_KEY = EVN["YELP_API_KEY"]

    def self.search(term, location)
        url = "#{API_HOST}#{SEARCH_PATH}location=#{location[:city]}, #{location[:state]}&term=#{term}&limit=2"
        #{
        # term: "name",
        # location: "location",
        # limit: SEARCH_LIMIT
        # }
        response = HTTP.auth("Bearer #{ENV['API_KEY']}").get(url) # (url, params: params)
        JSON.parse(response)
        #(response.to_json) ?
    end
end