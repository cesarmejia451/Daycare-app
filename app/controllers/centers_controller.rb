class CentersController < ApplicationController

  def index
    @centers = Center.all 
  end

  def show
    @center = Center.find(params[:id])
  end

  def search
    @centers = Center.where("neighborhood LIKE ? OR zip_code LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    
    render :index
  end
end

#rails includes method
#eager loading