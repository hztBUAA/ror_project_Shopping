class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer

  def new
    @address = @customer.addresses.build
  end

  def create
    @address = @customer.addresses.build(address_params)

    if @address.save
      redirect_to customers_commodities_path, notice: '收货地址创建成功！'
    else
      render :new
    end
  end

  def edit
    @address = @customer.address
  end

  def update
    @address = @customer.address

    if @address.update(address_params)
      redirect_to edit_customer_path(@customer), notice: '收货地址更新成功！'
    else
      render :edit
    end
  end

  def destroy
    @address = @customer.address
    @address.destroy

    redirect_to edit_customer_path(@customer), notice: '收货地址删除成功！'
  end

  private

  def set_customer
    @customer = current_user.customer
  end

  def address_params
    params.require(:address).permit(:country, :city, :house_address, :phone_number, :greeting_name)
  end
end
