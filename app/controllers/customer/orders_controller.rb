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

  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :subtotal, :payment_method, :name, :address, :postcode, :status)
  end
end
