class AccountController < ApplicationController
  before_action :authenticate_user!

  def recharge_form
  end

  def recharge
    if validate_params
      current_user.update(:account_balance => current_user.account_balance + params[:amount].to_f)
      redirect_to root_path, notice: "Account successfully recharged."
    else
      flash[:alert] = "Recharge value has invalid format."
      render :recharge_form
    end
  end

  private
  def validate_params
    true if Float(params[:amount]) rescue false
  end
end
