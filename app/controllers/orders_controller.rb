class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
    @total_payment = SHIPPING_COST + @total
  end

  def create
    @order = Order.find(params[:id])
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.save
    @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        @order_detail = @order.order_details.new
        @order_detail.item_id = cart_item.item.id
        @order_detail.amount = cart_item.amount
        @order_detail.purchase_price = cart_item.item.price
        @order_detail.product_status = 0
        @order_detail.save
      end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_to orders_path
  end

  def update
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
