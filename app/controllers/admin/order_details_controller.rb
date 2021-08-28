class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!, if: :admin_url

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    if @order_detail.update(order_detail_params)
      if @order_details.where(product_status: 3).count == @order_details.count
        @order_detail.order.update_attributes(status: 3)
      elsif @order_detail.order.status == 1
        @order_detail.order.update_attributes(status: 2)
      end
      redirect_to admin_order_path(@order_detail.order)
    end
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end

end
