class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :update, :destroy]

  # GET /breweries
  def index
    results = YelpApi.search(params[:name, :city, :state])
    @breweries = Brewery.all

    render json: @breweries, only: [:name, :city, :state]
  end

  # GET /breweries/1
  def show
    @brewery = Brewery.find_by(id: params[:yelp_id])

    if @brewery
      render json: { 
      yelp_id: brewery.id, 
      name: brewery.name, 
      city: brewery.city,
      state: brewery.state
    }
    else
      render json: { message: "Brewery not found" }
    end 
  end

  # POST /breweries
  def create
    @brewery = Brewery.new(brewery_params)
    if first.click? #(user hit submit)
    YelpApi.search(brewery_params) #search will occur, render results
    #then render results , confirm restaurant they want
    render json: #(results)
    else 
      #message: did you mean? , confirm second click
      @brewery.new(brewery_params)
    end
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
