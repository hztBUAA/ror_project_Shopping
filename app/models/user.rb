class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_default_role, on: :create#默认值为什么放在user模型中而不是controller

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable  #取消了:validatable  它会验证邮箱！！！
  has_one :admin, dependent: :destroy
  has_one :seller, dependent: :destroy
  has_one :customer, dependent: :destroy
  enum role: { customer: "customer", admin: "admin", seller: "seller" }#对上面的role进行了枚举
  def set_default_role
    self.role ||= :customer
  end
end
