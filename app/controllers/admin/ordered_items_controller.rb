class Admin::OrderedItemsController < ApplicationController
  def update
    @ordered_item = OrderedItem.find(params[:id])
    @order = @ordered_item.order
    @ordered_item.update(ordered_item_params)
  end

  private
  def ordered_item_params
    params.require(:ordered_item).permit(:making_status)
  end
end

