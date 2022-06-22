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
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postcode = @address.postcode
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_option] == "2"
    end
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.no_tax * cart_item.amount * 1.1}
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
    @ordered_items = @order.ordered_items.new
    @ordered_items.item_id = cart_item.item.id
    @ordered_items.price = cart_item.item.no_tax
    @ordered_items.amount = cart_item.amount
    @ordered_items.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

private
  def order_params
  params.require(:order).permit(:customer_id, :postage, :subtotal, :payment_method, :name, :address, :postcode, :status)
  end

end
