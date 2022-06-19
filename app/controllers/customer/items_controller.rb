class Customer::ItemsController < ApplicationController
  
  def show
  end
  
  def index
  end
  
  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :description, :no_tax, :is_active, :image)
  end

end
