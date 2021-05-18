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
#ATTEMPT ONE
  # POST /breweries
  # def create
  #   @brewery = Brewery.new(brewery_params)
    # /term = (brewery_params[:name])
    # /results = YelpApi.search(params[:name], params[:city])
    # /location = YelpApi.search(brewery_params[:city], brewery_params[:state])
  #   if @brewery.save
  #     render json:{ message: "Is this the brewery you were looking for?"}
  #   else
  #     render json: @brewery.errors, status: :unprocessable_entity
  #   end
  # end
# ATTEMPT 2
  # def create
  #   @brewery = Brewery.new(brewery_params)
  #   name = params[:name]
  #   city = params[:city]
  #   state = params[:state]
  #   location = {city: city, state: state}
  #   results = YelpApi.search(name, location)
  #   if @brewery.save 
  #     render results
  #   else
  #     render json:{ message: "Sorry, no brewery found"}
  #   end
  # end

  # ATTEMPT 3
  def create
    @brewery = Brewery.new(brewery_params)
   
    results = YelpApi.search(params[:name],[:location])
    # =[{"city" => 0 }])
    # byebug
    if @brewery.save
      render @brewery
    elsif @brewery = YelpApi.find_by(business_id: params[:business_id])
      render results
    else
      render json: {message: "Sorry no brewery found"}
    end
  end

  #POST ACTION WITHOUT API, !!DOES NOT REDIRECT BECAUSE OF HOW FRONTEND IS SET UP!!
  # def create
  #   @brewery = Brewery.new(brewery_params)
  #   if @brewery.save
  #         redirect_to breweries_path(@brewery)
  #   else
  #     render :new
  #   end
  # end

  def fetch_breweries #wrote this when I wanted to do 'separation of concerns' but will probably not use
    name = params[:name]
    city = params[:city]
    state = params[:state]
    location = {city: city, state: state}
    # results = YelpApi.search(name, location)
  end

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
      params.require(:brewery).permit(:name, :city, :state)
    end
  
end