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
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
    @order.update(order_params)
    if @order.status == 1
        @ordered_items.update_all(making_status: 1)
    end
    redirect_to admin_order_path(@order)
  end

  private
	def order_params
		  params.require(:order).permit(:status)
	end

end
