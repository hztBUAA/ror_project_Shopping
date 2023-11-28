class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show edit update destroy ]
  before_action :permit_params, only: [:purchase]
  before_action :set_commodity,only: %i[ purchase ]
  before_action :set_balance,only: %i[ purchase ]


  def recharge
    @customer = current_user.customer
  end

  def process_recharge
    @customer = current_user.customer
    amount = params[:amount].to_f
    @user = current_user
    # 执行充值逻辑，例如更新余额
    @user.update(balance: @user.balance + amount)

    redirect_to customers_commodities_path, notice: '充值成功！'
  end
  # GET /customers or /customers.json
    def purchase
      @order = Order.new
    end
  def add_to_my_cart
    # @customer.cart
  end
    def commodities
      @commodities = Commodity.all
    end
  def index
    @customers = Customer.all
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def permit_params
    params.permit(:commodity_id,:customer_id,:done)
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.fetch(:customer, {})
    end
    def set_commodity
      @commodity = Commodity.find(params[:commodity_id])
    end
  def set_balance
    @customer = Customer.find_by(user_id: current_user.id)
    @balance = @customer.user.balance
  end
end

