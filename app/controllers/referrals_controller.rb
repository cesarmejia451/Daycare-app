class ReferralsController < ApplicationController
  def index
    @referrals = Referral.all
  end

  def show
    @referral = Referral.find(params[:id])
  end

  def new
  end

  def create
    @referral = Referral.new({description: params[:description], user_id: current_user.id, center_id: params["center_id"]})

    if params[:description].empty?
      flash[:warning] = "You must enter text to complete review"
      redirect_to :back

    else @referral.save
      center_id = @referral.center_id
      flash[:success] = "Your referral has been added!!!"
      redirect_to "/centers/#{center_id}"
    end

  
  end

end
