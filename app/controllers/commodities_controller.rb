class CommoditiesController < ApplicationController
  before_action :set_commodity, only: %i[ show edit update destroy ]
  before_action :set_seller
  before_action :set_shop

  # GET /commodities or /commodities.json
  def index
    @shop = Shop.find(params[:shop_id])
    @commodities = @shop.commodities
  end

  # GET /commodities/1 or /commodities/1.json
  def show
    @comment = Comment.new
  end

  # GET /commodities/new
  def new
    @commodity = Commodity.new
  end

  # GET /commodities/1/edit
  def edit
  end

  # POST /commodities or /commodities.json
  def create
    @commodity = Commodity.new(commodity_params)
    @commodity.seller = @seller
    @commodity.shop = @shop
    respond_to do |format|
      if @commodity.save
        format.html { redirect_to seller_shop_commodity_path(@seller,@shop,@commodity), notice: "新增商品上架成功！" }
        format.json { render :index, status: :created, location: @commodity }
      else
        format.html { render :new, status: :unprocessable_entity,notice: "新增商品上架失败，请联系管理员！" }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commodities/1 or /commodities/1.json
  def update
    respond_to do |format|
      if @commodity.update(commodity_params)
        format.html { redirect_to seller_shop_commodity_path(@seller,@shop,@commodity), notice: "商品信息更新更新成功" }
        format.json { render :index, status: :ok, location: @commodity }
      else
        format.html { render :edit, status: :unprocessable_entity,notice: "商品信息更新失败，请联系管理员！" }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commodities/1 or /commodities/1.json
  def destroy
    # @commodity.shop.destroy if @commodity.shop
    # @commodity.category.destroy if @commodity.category
    # @commodity.seller.destroy if @commodity.seller
    # @commodity.orders.
    @commodity.destroy
    respond_to do |format|
      format.html { redirect_to seller_shop_commodities_path(@seller,@shop), notice: "所选商品下架成功！" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commodity
      @commodity = Commodity.find(params[:id])
    end
    def set_seller
      @seller = Seller.find(params[:seller_id])
    end
    def set_shop
      @shop = Shop.find(params[:shop_id])
    end

    # Only allow a list of trusted parameters through.
    def commodity_params
      # params.fetch(:commodity, {})
      params.require(:commodity).permit(:commodity_name, :price,:info,:image,:category_id,:count)
    end
end
