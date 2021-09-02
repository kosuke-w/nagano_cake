class OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
    @total_payment = SHIPPING_COST + @total
    if params[:order][:select_address] == "0"
      @customer = current_customer
      @order.postal_code = @customer.postal_code
      @order.address = @customer.address
      @order.name = @customer.last_name + @customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end

  end

  def create
    @order = Order.new(order_params)
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
    @order = Order.find(params[:id])
    @total = 0
    @subtotal = 0
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
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end

end
