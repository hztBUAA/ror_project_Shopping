class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_default_role, on: :create#默认值为什么放在user模型中而不是controller
  before_create :set_default_balance
  after_create :create_role_record
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable , :trackable #取消了:validatable  它会验证邮箱！！！
  has_one :admin, dependent: :destroy,class_name: "Admin"#这里的class_name是什么意思
  has_one :seller, dependent: :destroy,class_name: "Seller" #这里的class_name是什么意思
  has_one :customer, dependent: :destroy,class_name:  "Customer" #这里的class_name是什么意思
  enum role: { customer: "customer", admin: "admin", seller: "seller" }#对上面的role进行了枚举
  validates :user_name,presence:true
  has_one_attached :image
  def set_default_role
    self.role ||= :customer
  end
  private

  def create_role_record
    case role
    when "admin"
      Admin.create(user: self)
    when "seller"
      s = Seller.create(user: self)
      # s.shops = Shop.new
    when "customer"
      c = Customer.create(user: self)
      c.cart = Cart.new
    else
      # type code here
    end
  end


  def set_default_balance
    self.balance ||= 0
  end

end
