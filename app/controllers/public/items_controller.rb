class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @items_all = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
