class CentersController < ApplicationController

  def index
    @centers = Center.all

    if params[:program]
      @centers = Program.find_by(name: params[:program]).centers
    end
  end

  def show
    @center = Center.find(params[:id])
    @image_api = ENV["IMG_API"]
    @image_street_api = ENV["IMG_STREET_API"]
    @geocode_api = ENV["GEOCODE_API"]
    @hours_api = ENV["HOURS_API"]

    @users_location = Geocoder.search("173.208.66.199").first 
    
  end

  def search
    @centers = Center.where("name LIKE ? OR zip_code LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    
    render :index
  end

  def api_search
     @centers = Center.where("name LIKE ? OR zip_code LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
     render json: @centers
  end
end

