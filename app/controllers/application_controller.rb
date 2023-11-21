class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :roles, :all_roles, :current_admin?, :current_seller?, :current_customer?


  def roles
    %w[Seller Customer]
  end

  def all_roles
    %w[Seller Customer Admin]
  end

  def current_admin?
    current("Admin")
  end

  def current_seller?
    current("Seller")
  end

  def current_customer?
    current("Customer")
  end

  private
  def current(role)
    current_user && current_user.role == role
  end
end
