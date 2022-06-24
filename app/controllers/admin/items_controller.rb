class Admin::ItemsController < ApplicationController
  before_action :set_genres, only: [:new, :edit, :index, :create, :update]
  before_action :authenticate_admin!

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "登録しました"
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "更新しました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :description, :no_tax, :is_active, :image)
  end

  def  set_genres
    @genres = Genre.all
  end

end
