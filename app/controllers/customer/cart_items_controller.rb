class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @update_cart_item =  current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    if  @update_cart_item.present?
        @update_cart_item.amount += params[:cart_item][:amount].to_i
        #binding.pry
        @update_cart_item.save
        redirect_to cart_items_path
    else
        if @cart_item.save
          flash[:notice] = "カートに追加しました"
          redirect_to cart_items_path
        else
          @item = Item.find(params[:cart_item][:item_id])
          @cart_item = CartItem.new
          flash[:alert] = "個数を選択してください"
          render "customer/items/show"
        end
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.no_tax * cart_item.amount * 1.1}
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(amount: params[:cart_item][:amount].to_i)
      flash[:notice] = "数量変更しました"
      redirect_to cart_items_path
    end
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
