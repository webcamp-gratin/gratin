class Customer::ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def index
    @items = Item.page(params[:page]).per(8)
    @item = Item.all
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :description, :no_tax, :is_active, :image)
  end

end
