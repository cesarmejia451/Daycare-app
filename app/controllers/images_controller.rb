class ImagesController < ApplicationController 

  def new
  end

  def create
    @image = Image.create({url: params[:url], center_id: params[:center][:center_id]})
    redirect_to "/centers/#{@image.center_id}"
  end 

  def destroy
    @image = @image.find(params[:id])
    @image.destroy

    redirect_to "/centers/#{@center.id}"
  end 
end
