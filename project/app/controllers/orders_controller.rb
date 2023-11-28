class OrdersController < ApplicationController
  # before_action :permit_params,except: %i[new]
  # before_action :set_order, only: %i[ show edit update destroy ]
  # before_action :set_customer
  # before_action :set_commodity ,except: %i[ create index show]
  # GET /orders or /orders.json
  def index
    @orders = Order.all
    @customer = current_user.customer
  end

  # GET /orders/1 or /orders/1.json
  def show
@order = Order.find(params[:id])
@customer = current_user.customer
  end

  # GET /orders/new
  def new
    @customer = current_user.customer
    @commodity = Commodity.find(params[:commodity_id])
    @done = params[:done]
    # @price = @commodity.price
    @order = Order.new
    @order.commodity_id = @commodity.id
    @order.done = @done
  end

  # GET /orders/1/edit
  def edit
    @customer = current_user.customer
    @order = Order.find(params[:id])
  end

  # POST /orders or /orders.json
  def create
    # debugger
    @customer = current_user.customer
    @order = Order.new(order_params)
    @order.address = Address.find(params[:order][:address_id])
    @order.count =  params[:order][:count]
    @order.commodity = Commodity.find(params[:order][:commodity_id])
    @order.customer = Customer.find(params[:order][:customer_id])
    @order.done = params[:order][:done]
    @order.cart_id = @customer.cart.id

    @commodity = Commodity.find(params[:order][:commodity_id])
    @balance = @customer.user.balance
    if @order.done == true

      if @commodity.count>=1 && @balance>=@commodity.price

        @commodity.count = @commodity.count-1
        @balance = @balance - @commodity.price
        @customer.user.balance = @balance
        @commodity.save
        @customer.user.save

        # redirect_to "home/index"
      else
        if @commodity.count<1
          redirect_to customers_commodities_path, notice: "购买失败！商品已经被人抢光啦！."
        else
          redirect_to customers_commodities_path, notice: "余额不足！"
        end
      end
    end
    respond_to do |format|
      if @order.save
        format.html { redirect_to customers_commodities_path(@customer), notice: @order.done ? "支付成功！" : "订单创建成功，可在购物车中查询您的宝贝。" }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(permit_params)
        format.html { redirect_to customer_order_path(@customer,@order), notice: "订单更新成功！" }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to customer_orders_path(@customer), notice: "订单删除成功！" }
      format.json { head :no_content }
    end
  end

  def order_params
    params.require(:order).permit(:address_id, :count, :customer_id, :commodity_id, :done)
  end
end
