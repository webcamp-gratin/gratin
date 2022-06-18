class Customer::CustomersController < ApplicationController

  def show
    @customer == current_customer
  end

  def edit
    @customer == current_customer
  end

  def update
    @customer == current_customer
    @customer.update(customer_params)
    redirect_to customer_path

  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :is_delete)
  end
end
