class UserController < ApplicationController

  def show
    @user = User.find(params[:id])#什么时候确定是 id   应该可以自己在routes中设置？？？
  end

  def index
    @users = User.all
  end

  def update
    @user = current_user
    unless params[:user] && params[:user][:image].present?
      redirect_back(fallback_location: root_path)
      return
    end
    if @user.update(params.require(:user).permit(:image))
      redirect_to user_path, notice: '头像上传成功！'
    else
      render :'home/index', notice: '头像上传失败！.'
    end
  end



  # def image
  #   @user = current_user
  #   send_data @user.image.download, type: @user.image.content_type, disposition: 'inline'
  # end


end
