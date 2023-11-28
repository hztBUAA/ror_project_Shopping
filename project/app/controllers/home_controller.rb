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
end
