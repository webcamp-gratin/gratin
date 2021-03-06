class Admin::OrderedItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @ordered_item = OrderedItem.find(params[:id])
    @order = @ordered_item.order
    @ordered_item.update(ordered_item_params)
    if ordered_item_params[:making_status] == "cooking"
      @order.update(status: 2)
    elsif ordered_item_params[:making_status] == "completed"
      @order.update(status: 3)
    end
    redirect_to request.referer
  end

  private
  def ordered_item_params
    params.require(:ordered_item).permit(:making_status)
  end
end

