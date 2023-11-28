# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  private

  def configure_account_update_params
    # 在这里添加允许的参数
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :image])
  end

  def update
    # 在原有的 update 方法中调用 super，保留 Devise 的默认逻辑
    super do |resource|
      # 在这里处理图片的逻辑
      if params[:user][:image].present?
        # 处理上传的图片，例如保存到数据库或存储在云存储中
        # 这里的逻辑取决于你的需求
        resource.image = params[:user][:image]
        resource.save
      end
    end
  end
end
