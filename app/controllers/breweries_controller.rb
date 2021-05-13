class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :update, :destroy]

  # GET /breweries
  def index
    @breweries = Brewery.all

    render json: @breweries, only: [:id, :name, :location, :hours, :phone_number, :img_url]
  end

  # GET /breweries/1
  def show
    brewery = Brewery.find_by(id: params[:id])

    if brewery
      render json: { 
      id: brewery.id, 
      name: brewery.name, 
      location: brewery.location, 
      hours: brewery.hours, 
      phone_number: brewery.phone_number, 
      img_url: brewery.img_url 
    }
    else
      render json: { message: "Brewery not found" }
    end 
  end

  # POST /breweries
  def create
    @brewery = Brewery.new(brewery_params)

    if @brewery.save
      render json: @brewery, status: :created, location: @brewery
    else
      render json: @brewery.errors, status: :unprocessable_entity
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
      params.require(:brewery).permit(:name, :location, :hours, :phone_number, :img_url)
    end
end
