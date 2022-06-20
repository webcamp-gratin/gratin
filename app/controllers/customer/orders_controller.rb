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
  
  def confirm
    @order = Order.new
    if params[:order][:address] == "own_address"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.customer_address
      @order.name = current_customer.name
    elsif params[:order][:address] == "registered_address"
      
      
    @address = Address.find(params[:order][:address_id])
    @order.postcode = current_customer.postcode
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :subtotal, :payment_method, :name, :address, :postcode, :status)
  end
end
