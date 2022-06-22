class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_confirm_path
  end

  def index
    @orders = Order.all
  end

  def show
    @oredr = Order.find(params[:id])
  end

  #newから送られてきたパラメータの取得
  def confirm
    @order = Order.new(customer: current_customer)

    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.no_tax * cart_item.amount * 1.1}

  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :subtotal, :payment_method, :name, :address, :postcode, :status)
  end

  def address_params
    params.require(:order).permit(:postcode, :address, :name)
  end
end
