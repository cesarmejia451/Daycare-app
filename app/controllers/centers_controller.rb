class CentersController < ApplicationController
  
  def index
    @centers = Center.all 
  end
end
