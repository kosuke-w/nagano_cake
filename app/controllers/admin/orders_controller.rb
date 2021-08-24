class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @subtotal = 0
    @total = 0
  end

  def update
  end
end
