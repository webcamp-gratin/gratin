class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customer = Customer.find(params[:id])
  end

  def index
    @customers = Customer.page(params[:page])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "更新しました"
      redirect_to admin_customer_path
    else
      render :edit
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

    private
    def customer_params
        params.require(:customer).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :is_deleted)
    end
end
