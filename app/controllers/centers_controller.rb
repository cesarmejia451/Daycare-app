class CentersController < ApplicationController

  def index
    @centers = Daycare.all

    if params[:program]
      @centers = Program.find_by(name: params[:program]).centers
    end
  end

  def show
    @center = Daycare.find(params[:id])
  end

  def search
    @centers = Center.where("neighborhood LIKE ? OR zip_code LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    
    render :index
  end
end

#rails includes method
#eager loading