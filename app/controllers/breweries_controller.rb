class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :update, :destroy]
  
  # GET /breweries
  def index
    @breweries = Brewery.all

    render json: @breweries, only: [:id, :name, :city, :state]
  end

  # GET /breweries/1
  def show
    @brewery = Brewery.find_by(id: params[:id])

    if brewery
      render json: { 
      id: brewery.id, 
      name: brewery.name, 
      city: brewery.city, 
      state: brewery.state
    }
    else
      render json: { message: "Brewery not found" }
    end 
  end

  # ATTEMPT 3
  def create
   
    # @brewery = Brewery.new(brewery_params)
    location = "#{params[:city]}, #{params[:state]}"
    results = YelpApi.search(params[:name], location)
        if results["businesses"].to_s.length > 0
          render json: results
    else
      render json: {message: "Sorry no brewery found"}
    end
  end

  #SECOND CLICK AFTER LIST SHOWS UP AND USER HITS SUBMIT:
    #still going to be handled in the create method for now (get it to work, then worry about splitting later)
    #want to check to see if there's a yelp_id, that's how you know it came from the confirm
    #if it has a yelp_id, create that brewery in the backend database #\
    #render: message "brewery created" and/or render brewery back

  # PATCH/PUT /breweries/1
  def update
    if @brewery.update(brewery_params)
      render json: @brewery
    else
      render json: @brewery.errors, status: :unprocessable_entity
    end
  end

  # DELETE /breweries/1
  def destroy
    @brewery.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def brewery_params
      params.require(:brewery).permit(:id, :name, :city, :state)
    end
  
end