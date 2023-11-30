class CartsController < ApplicationController
  before_action :set_customer
  before_action :set_cart

  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show

  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
    @customer = current_user.customer
    # 获取购物车及其订单
    @cart = @customer.cart
    @orders = @cart.orders

  end
  def delete_selected
    # 获取选中的订单的 IDs
    selected_order_ids = params[:order_ids]

    # 确保有选中的订单
    if selected_order_ids.present?
      # 在这里添加删除订单的逻辑，例如：
      Order.where(id: selected_order_ids).destroy_all

      # 重定向到购物车页面或其他适当的页面
      redirect_to customer_cart_path(@customer), notice: '选中订单已删除'
    else
      # 如果没有选中的订单，可能显示一个提示信息
      redirect_to customer_cart_path(@customer), alert: '请选择要删除的订单'
    end
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params)
    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :index, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @customer = current_user.customer
    @cart =@customer.cart


    if params[:commit] == "支付选中订单"
      # 处理支付选中订单的逻辑
      selected_order_ids = params[:order_ids].reject(&:empty?)
      selected_orders = @cart.orders.where(id: selected_order_ids)

      # 计算支付总金额
      total_amount = selected_orders.sum { |order| order.commodity.price * order.count }

      # 检查顾客的余额是否足够支付
      if @customer.user.balance >= total_amount
        # 开始支付逻辑...

        # 更新商品的销量和库存
        selected_orders.each do |order|
          commodity = order.commodity
          commodity.update(
            sales: commodity.sales + order.count,
            count: commodity.count - order.count
          )
        end

        # 扣除顾客的余额
        @customer.user.update(balance: @customer.user.balance - total_amount)

        # 更新订单状态
        selected_orders.update_all(done: true)

        redirect_to customer_cart_path(@customer), notice: "您勾选的商品已经支付成功！"
      else
        redirect_to customer_cart_path(@customer), alert: "余额不足，支付失败！"
      end
    elsif params[:commit] == "删除选中订单"
      # 处理删除选中订单的逻辑
      selected_order_ids = params[:order_ids]&.reject(&:empty?) || []
      selected_orders = @cart.orders.where(id: selected_order_ids)
      selected_orders.destroy_all
      # 进行删除逻辑...
      redirect_to customer_cart_path(@customer), notice: "您勾选的商品已经删除成功！"
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json


  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private



  private
    # Use callbacks to share common setup or constraints between actions.
  def set_customer
    # code here
    @customer = Customer.find(params[:customer_id])
  end
  def set_cart
    @cart = @customer.cart
  end
    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end
end
