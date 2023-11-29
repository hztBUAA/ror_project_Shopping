class HomeController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = current_user
    # @blogs = current_user.blogs.find[:]
    # @comment = current_user.blogs
  end

  def recent_logins
    if current_customer?
      @recent_logins = User.where(role: 'customer').order(last_sign_in_at: :desc).limit(10)
    elsif current_seller?
      @recent_logins = User.where(role: 'seller').order(last_sign_in_at: :desc).limit(10)
    end
  end
end
