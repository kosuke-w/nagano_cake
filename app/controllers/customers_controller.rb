class CustomersController < ApplicationController

  before_action :authenticate_customer!, only: [:show]

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customers_my_page_path
  end

  def unsubscribe
    @customer = Customer.find(current_customer.id)
  end

  def check
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: "Invalid")
    reset_session
    redirect_to root_path
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
    end

end