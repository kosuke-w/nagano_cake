class ItemsController < ApplicationController

  before_action :authenticate_customer!, except: [:show, :index]

  def index
    @items = Item.all
    @items = Item.page(params[:page]).per(10)
  end

  def new
  end

  def create
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def edit
  end

  def update
  end
end
