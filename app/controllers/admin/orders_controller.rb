class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!, if: :admin_url

  def show
    @order = Order.find(params[:id])
    @subtotal = 0
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "入金確認"
        @order.order_details.update_all(product_status: 1)
      end
      redirect_to admin_order_path(@order.id)
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end
