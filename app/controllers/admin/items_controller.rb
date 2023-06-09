class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.page(params[:page])
    @items_all = Item.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    end
  end

  def update
     @item = Item.find(params[:id])
     if @item.update(item_params)
       redirect_to admin_item_path(@item)
     else
       render :edit
     end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end
end
