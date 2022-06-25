class SearchesController < ApplicationController

  def search
		@model = params[:model]
		@content = params[:content]
		@model == 'item'
		@records = Item.search_for(@content)
	end

end
