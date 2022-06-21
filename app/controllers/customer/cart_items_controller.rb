class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = params[:item_id]
    @cart_item.save
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.no_tax * cart_item.amount * 1.1}
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end



  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
