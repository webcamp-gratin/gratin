class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
    @total_price = @ordered_items.sum{|ordered_item|ordered_item.item.no_tax * ordered_item.amount * 1.1}
  end

  def index
    @orders = Order.page(params[:page])
  end

  def update
  end

  private
	def order_params
		  params.require(:order).permit(:status)
	end

end
