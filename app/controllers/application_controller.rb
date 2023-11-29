class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :roles, :all_roles, :current_admin?, :current_seller?, :current_customer?
  before_action :configure_permitted_parameters, if: :devise_controller?



  def roles
    %w[seller customer]
  end

  def all_roles
    %w[seller customer admin]
  end

  def current_admin?
    current("admin")
  end

  def current_seller?
    current("seller")
  end

  def current_customer?
    current("customer")
  end

  private
  def current(role)
    current_user && current_user.role == role
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :image])
  end
end
