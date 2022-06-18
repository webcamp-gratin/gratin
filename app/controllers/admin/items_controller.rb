class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    
      redirect_to admin_item_path(@item)
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update!(item_params)
    redirect_to admin_item_path
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :description, :no_tax, :is_active, :image)
  end

end
