class Admin::OrdersController < ApplicationController
  def show
  end

  def index
  end

  def update
  end

  private
	def order_params
		  params.require(:order).permit(:status)
	end

end
