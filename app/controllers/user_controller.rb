class UserController < ApplicationController

  def show
    @user = User.find(params[:id])#什么时候确定是 id   应该可以自己在routes中设置？？？
  end

  def index
    @users = User.all
  end


end
