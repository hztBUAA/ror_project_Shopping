class ShopsController < ApplicationController
  before_action :set_shop_and_seller

  # GET /shops or /shops.json
  def index
    @seller = current_user.seller
    @shops = @seller.shops
  end

  # GET /shops/1 or /shops/1.json
  def show

  end

  # GET /shops/new
  def new
    # new函数的跳转逻辑 是先到new方法？吗
    @seller = current_user.seller
    unless @seller
      redirect_to home_index_path,notice:" seller is  nil"
    end
    @shop = Shop.new
    @shop.seller_id = @seller.id
    # @shop = Shop.new
    # @seller = current_user.seller

    # @name = current_user.user_name
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops or /shops.json
  def create
    @shop = Shop.new(shop_params)
    @shop.seller_id = @seller.id
    respond_to do |format|
      if @shop.save
        format.html { redirect_to seller_shops_path(@seller), notice: "Shop was successfully created." }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1 or /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to seller_shop_path(@shop), notice: "Shop was successfully updated." }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1 or /shops/1.json
  def destroy


    if @shop.commodities.destroy_all
      redirect_to seller_shops_path(@seller), notice: "超市删除成功！"
    else
      redirect_to seller_shops_path(@seller), notice: "超市删除失败，请将超市内商品下架后并与对应订单顾客联系或者和管理员联系！"
    end

    # respond_to do |format|
    #   format.html { redirect_to seller_shops_path(@seller), notice: "Shop was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_and_seller
      if current_seller?
        @seller = current_user.seller
      else
        @seller = Seller.find(params[:seller_id])
        # redirect_to root_path
      end
      # @seller = current_user.seller
      if params[:id]
        @shop = Shop.find(params[:id])
      else
        @shop = Shop.new
      end

      #还需要seller_id吗   其实不需要      找shop表只用主键
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      params.require(:shop).permit(:shop_name, :info )
    end
end
