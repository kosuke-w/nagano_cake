class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!, if: :admin_url

  def top
    @orders = Order.all
    @orders = Order.page(params[:page]).per(10)
    @total_amount = 0
  end

end
