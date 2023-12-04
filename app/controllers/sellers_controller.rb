class SellersController < ApplicationController
  before_action :set_seller, only: %i[ show edit update destroy ]

  # GET /sellers or /sellers.json
  def index
    @sellers = Seller.all
  end

  # GET /sellers/1 or /sellers/1.json
  def show
    @shops = @seller.shops
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers or /sellers.json
  def create
    @seller = Seller.new(seller_params)

    respond_to do |format|
      if @seller.save
        format.html { redirect_to seller_url(@seller), notice: "Seller was successfully created." }
        format.json { render :index, status: :created, location: @seller }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1 or /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to seller_url(@seller), notice: "Seller was successfully updated." }
        format.json { render :index, status: :ok, location: @seller }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1 or /sellers/1.json
  def destroy
    @seller.destroy

    respond_to do |format|
      format.html { redirect_to sellers_url, notice: "Seller was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def shipping_one_order
    @seller = current_user.seller
    @orders = @seller.orders
    @orders = @orders.where(status: STATUS_MAPPING['pending_shipping'])
    #将订单状态改为已发货
    redirect_to seller_orders_path(@seller), notice: "订单已发货！"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      if current_user.seller
        @seller = current_user.seller
      else
        @seller = Seller.find(params[:id])
      end
      @name = User.find(@seller.user_id).user_name
      # @name = @seller.user.user_name
    end

    # Only allow a list of trusted parameters through.
    def seller_params
      params.fetch(:seller, {})
    end
end
