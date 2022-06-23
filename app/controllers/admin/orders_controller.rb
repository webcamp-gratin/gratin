class Admin::OrdersController < ApplicationController
  def show
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
