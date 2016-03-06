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
    @referral = Referral.create({description: params[:description], user_id: current_user.id, center_id: params["center_id"]})
    center_id = @referral.center_id
    redirect_to "/centers/#{center_id}"
  end

end
