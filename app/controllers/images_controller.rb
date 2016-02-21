class ImagesController < ApplicationController 

  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
  end


  def new
  end

  def create
    @image = Image.create({url: params[:url], center_id: params[:center][:center_id]})
    center_id = @image.center_id
    redirect_to "/centers/#{center_id}"
  end 

  def destroy
    @image = Image.find(params[:id])
    center_id = @image.center_id
    @image.destroy

    flash[:warning] = "Your image was successfully removed."
    redirect_to "/centers/#{center_id}"
  end 
end
