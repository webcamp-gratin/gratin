class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to customer_confirm_path
  end

  def index
    @orders = Order.all
  end

  def show
    @oredr = Order.find(params[:id])
  end

  #newから送られてきたパラメータの取得
  def confirm
    @order = Order.new(order_params)
    if params[:order][:address] == "own_address" 
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.name
    elsif params[:order][:address] == "registered_address"
      @order.postcode = current_user.find(params[:order][:registered_address]).postcode
      @order.address = current_user.find(params[:order][:registered_address]).address
      @order.name = current_user.find(params[:order][:registered_address]).name
    elsif params[:order][:address] == "new_address"
      @order.postcode = params[:order][:postcode]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end


  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :subtotal, :payment_method, :name, :address, :postcode, :status)
  end

  def address_params
    params.require(:order).permit(:postcode, :address, :name)
  end
end
