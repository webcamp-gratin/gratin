class Customer::AddressesController < ApplicationController

  def create
  end

  def index
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :address, :postcode)
  end
end
