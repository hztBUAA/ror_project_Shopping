## 总体概览

本电商网站共涉及11个实体，有三个主要角色：顾客、商家和管理员，不同角色具有不同的职责和功能（下面会详述）。参照本人的生活体验以及对各大电商网站的实际界面的借鉴学习，使用了包括css和js的页面美化，贴合用户实际。同时支持图片上传功能，包括商品图片的显示，用户头像的上传等等。

### 顾客

顾客是电商平台的普通用户，他们可以通过注册和登录来访问平台。一旦登录，顾客可以浏览平台上的商品，将心仪的商品加入购物车，进行下单购买。在购物的过程中，顾客可以管理个人信息，包括修改密码、添加或删除收货地址等。顾客还可以查看订单历史，了解订单状态，并进行支付操作。购物车和订单管理是顾客在平台上的核心功能，使他们能够方便快捷地完成购物流程。

### 商家

商家是平台上的商品供应者，他们可以注册并创建自己的店铺。商家可以在店铺中上架商品，下架商品，更改商品信息，更改店铺信息，管理商品分类。

### 管理员

管理员是电商平台的管理者，拥有最高的权限。他们可以管理用户、商品，进而查看和管理所有信息。在用户管理方面，管理员可以查看用户信息，注销用户账号。对于商品和店铺，管理员有权添加和删除商品种类，进而控制商品的增加和删除；查看所有卖家的店铺信息，并拥有删除商家进而取消其营业的资格。订单管理是管理员的主要职责，他们可以查看所有订单，确保订单的正常进行。

## 难点总结和收获

- 数据库表中的删除的处理很容易产生错误，需要对rails中的方法的dependent: :destroy的方法的处理有很深入的理解，否则一不小心就会陷入外键约束的红色页面的报错，又或者是删除之后根本没有真正删除还会显示的尴尬局面。
  - 对此我在实践中，给自己一个大致的总结，~~不确定是否正确~~：
    - 对于User has one seller **现在注销seller的账户**
      - 如果设置的是dependent: :destroy，**那么在users表中的确删除了这条记录，同时也会将sellers表中的相关联的记录删除**，这是**工程中正确的做法**。
      - 反之，如果没有加上dependent: :destroy,**那么确实sellers表中的对应记录会删除，然而在users表中并没有删除这条记录**，只是会将user对应的seller_id置为nil，表示不存在这个外键对应的user记录了，**这是符合数据库的外键的约束的，但很可能不是我们工程中想要的（~~当然指的是开发者水平有限导致的错误~~）**——这样会出现删除了对应的seller记录，然而用户登录时是以user模型登录的，其角色字段role仍然==seller，会出现前端页面中的seller_id = nil的错误。
    - 那么全都采用destroy一定就工程上正确吗？
      - 并不是
      - 这样子就可能在复杂的关系模型中**导致数据库的外键约束报错同时也不一定符合逻辑** 具体体现在自己处理删除超市的逻辑时就遇到删除超市->删除商品->然而商品又被订单关联，于是会引发错误。
      - 这是需要手动的进行删除的逻辑编写
- 这学期个人从完全没有前端和后端开发经验到使用rails开发了若干个小项目，成就感是个人大学以来最大的。同时挑战也很明显，具体体现在ror的学习路线确实很陡峭，一句**约定大于配置**，解放了程序员的双手，也让大量的help_method成为学习路上的绊脚石，一定程度上去打破这些约定就会出现很多让人难受的问题。
- 前端的尝试也是很容易让人上瘾~ 痛并快乐着！
- 同时个人在学习开发的过程中，尝试跟着视频教程去部署网站，但遇到了很多问题，包括阿里云的github拉取缓慢（~~更改代理~~），heroku的绑定visa卡似乎难以支持国内卡（~~提示card declined~~），让自己想要和家人朋友分享的炽热心一次次被浇冷水，蓝瘦~

## 数据库表：

1. **`users`表:**
   - 与`admins`表通过`user_id`建立一对一关系，表示管理员用户。
   - 与`customers`表通过`user_id`建立一对一关系，表示普通顾客用户。
   - 与`sellers`表通过`user_id`建立一对一关系，表示卖家用户。

2. **`admins`表:**
   - 表示管理员用户，通过`user_id`与`users`表建立一对一关系。

3. **`customers`表:**
   - 与`users`表通过`user_id`建立一对一关系，表示普通顾客用户。
   - 与`carts`表通过`cart_id`建立一对一关系，表示顾客的购物车。

4. **`carts`表:**
   - 与`customers`表通过`cart_id`建立一对一关系，表示购物车。
   - 与`orders`表通过`cart_id`建立一对多关系，表示购物车中的订单。

5. **`orders`表:**
   - 与`commodities`表通过`commodity_id`建立多对一关系，表示订单中的商品。
   - 与`customers`表通过`customer_id`建立多对一关系，表示订单所属的顾客。
   - 与`addresses`表通过`address_id`建立多对一关系，表示订单的配送地址。

6. **`commodities`表:**
   - 与`categories`表通过`category_id`建立多对一关系，表示商品所属的类别。
   - 与`sellers`表通过`seller_id`建立多对一关系，表示商品的卖家。
   - 与`shops`表通过`shop_id`建立多对一关系，表示商品所属的商店。
   - 与`images`表通过`image_id`建立多对一关系，表示商品的图片。

7. **`sellers`表:**
   - 与`users`表通过`user_id`建立一对一关系，表示卖家用户。
   - 与`shops`表通过`seller_id`建立一对多关系，表示卖家拥有的商店。

8. **`shops`表:**
   - 与`sellers`表通过`seller_id`建立多对一关系，表示商店的卖家。
   - 与`images`表通过`image_id`建立多对一关系，表示商店的图片。

9. **`addresses`表:**
   - 与`customers`表通过`customer_id`建立一对多关系，表示顾客的配送地址。

10. **`images`表:**
    - 与`commodities`表通过`image_id`建立多对一关系，表示商品的图片。
    - 与`shops`表通过`image_id`建立多对一关系，表示商店的图片。

11. **`categories`表:**
    - 与`commodities`表通过`category_id`建立一对多关系，表示商品所属的类别。

12. **`active_storage_attachments`表:**
    - 与`active_storage_blobs`表通过`blob_id`建立多对一关系，表示附件的存储关系。

13. **`active_storage_blobs`表:**
    - 与`active_storage_attachments`表通过`blob_id`建立一对多关系，表示附件的存储关系。
    - 与`active_storage_variant_records`表通过`blob_id`建立一对多关系，表示变体记录与附件的关系。

14. **`active_storage_variant_records`表:**
    - 与`active_storage_blobs`表通过`blob_id`建立多对一关系，表示变体记录与附件的关系。

## 实体
让我们简要介绍你的11个实体，以及它们在电商网站中的交互：

1. **Address（地址）:**
   - 保存顾客的配送地址信息。
   - 关联到顾客（Customer），表示一个顾客可以有多个地址。
   - 定义了 `full_address` 方法，返回格式化的完整地址字符串。

```ruby
class Address < ApplicationRecord
  belongs_to :customer, dependent: :delete_all

  def full_address
    "#{country}, #{city}, #{house_address}, #{phone_number}, #{greeting_name}"
  end
end
```

2. **Admin（管理员）:**
   - 保存管理员用户的信息。
   - 关联到用户（User），表示一个管理员对应一个用户。

```ruby
class Admin < ApplicationRecord
  belongs_to :user, dependent: :delete
end
```

3. **Cart（购物车）:**
   - 保存顾客的购物车信息。
   - 一个购物车关联到一个顾客，通过 `customer_id`。
   - 有多个订单（Order）与购物车关联，通过 `has_many :orders`。
   - 与顾客关联，表示一个顾客只有一个购物车。

```ruby
class Cart < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :customer, dependent: :destroy
end
```

4. **Category（商品类别）:**
   - 保存商品类别的信息。
   - 有多个商品（Commodity）与类别关联，通过 `has_many :commodities`。

```ruby
class Category < ApplicationRecord
  has_many :commodities, dependent: :destroy
  validates :name, presence: true
end
```

5. **Commodity（商品）:**
   - 保存商品的信息。
   - 关联到商品类别（Category）、商店（Shop）、卖家（Seller）、订单（Order）和图片（Image）。
   - 使用 `has_one_attached :image` 来处理商品图片附件。

```ruby
class Commodity < ApplicationRecord
  belongs_to :category, dependent: :destroy
  belongs_to :shop, dependent: :destroy
  belongs_to :seller
  has_many :orders
  has_one_attached :image
end
```

6. **Customer（顾客）:**
   - 保存顾客用户的信息。
   - 有一个购物车（Cart）与顾客关联，通过 `has_one :cart`。
   - 有多个地址（Address）与顾客关联，通过 `has_many :addresses`。
   - 关联到用户（User），表示一个顾客对应一个用户。

```ruby
class Customer < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :orders, through: :cart, source: :orders
  has_many :addresses
  belongs_to :user, dependent: :delete
end
```

7. **Image（图片）:**
   - 用于保存图片的信息。
   - 与商品（Commodity）和商店（Shop）等多个实体通过 `has_one_attached :image` 关联。

```ruby
class Image < ApplicationRecord
  has_one_attached :image
  validates :image, content_type: { in: %w[image/jpeg image/png image/gif], message: 'must be a valid image format' },
            size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end
```

8. **Order（订单）:**
   - 保存订单的信息。
   - 与商品（Commodity）、顾客（Customer）、配送地址（Address）和购物车（Cart）关联。
   - 使用 `belongs_to` 表示多个订单属于一个商品、一个顾客等。

```ruby
class Order < ApplicationRecord
  belongs_to :commodity
  belongs_to :customer
  validates :count, presence: true
  belongs_to :address
end
```

9. **Seller（卖家）:**
   - 保存卖家用户的信息。
   - 有多个商店（Shop）和商品（Commodity）与卖家关联。
   - 关联到用户（User），表示一个卖家对应一个用户。

```ruby
class Seller < ApplicationRecord
  has_many :shops, dependent: :delete_all
  has_many :commodities, through: :shops, dependent: :delete_all
  belongs_to :user, dependent: :delete
end
```

10. **Shop（商店）:**
    - 保存商店的信息。
    - 有多个商品（Commodity）与商店关联。
    - 与卖家（Seller）关联。

```ruby
class Shop < ApplicationRecord
  belongs_to :seller, dependent: :delete
  has_many :commodities, dependent: :delete_all
end
```
11. **User（用户）:**
    - 保存用户的信息，包括管理员、卖家和顾客。
    - 有一个管理员、卖家和顾客与用户关联。
    - 使用 `enum` 枚举表示用户的角色。
    - 使用 `has_one_attached :image` 处理用户的图片附件。

```ruby
class User < ApplicationRecord
  has_one :admin, dependent: :destroy, class_name: "Admin"
  has_one :seller, dependent: :destroy, class_name: "Seller"
  has_one :customer, dependent: :destroy, class_name:  "Customer"
  enum role: { customer: "customer", admin: "admin", seller: "seller" }
  validates :user_name, presence: true
  has_one_attached :image

  before_validation :set_default_role, on: :create
  before_create :set_default_balance
  after_create :create_role_record

  def set_default_role
    self.role ||= :customer
  end

  private

  def create_role_record
    case role
    when "admin"
      Admin.create(user: self)
    when "seller"
      Seller.create(user: self)
    when "customer"
      Customer.create(user: self)
    else
      # type code here
    end
  end

  def set_default_balance
    self.balance ||= 0
  end
end
```

## 后端逻辑

明白，我将突出设计的重点并将控制器的代码与功能绑定在一起。

### 用户与权限

### 1. AdminsController
- **设计重点：** 管理员控制器，用于管理商品和订单。
- **功能绑定：** 
  - `commodities` Action：获取并显示所有商品的信息。
  - `orders` Action：获取并显示所有订单的信息。

### 2. UserController
- **设计重点：** 用户控制器，用于显示用户信息。
- **功能绑定：** 
  - `show` Action：显示单个用户的信息。
  - `index` Action：显示所有用户的信息。

### 3. CustomersController
- **设计重点：** 顾客控制器，用于处理顾客的充值、购物和订单。
- **功能绑定：** 
  - `recharge` Action：显示充值页面和处理充值逻辑。
  - `purchase` Action：显示购物页面，允许顾客创建新订单。
  - `process_recharge` Action：处理充值逻辑，更新用户余额。

### 4. SellersController
- **设计重点：** 卖家控制器，用于管理商家信息。
- **功能绑定：** 
  - `index` Action：获取并显示所有卖家的信息。
  - `show` Action：显示单个卖家的信息，包括其拥有的商店信息。

将每个控制器的设计目标和功能都清晰绑定在一起，使得代码的结构更容易理解和维护。 AdminsController 处理管理员的功能， UserController 处理用户，拓展Devise生成的User功能， CustomersController 处理顾客的充值和购物， SellersController 处理买家的上市商品和查看订单功能。

### 顾客功能

### 5. CartsController
- **设计重点：** 购物车控制器，处理购物车的创建、编辑、支付和删除。
- **功能绑定：** 
  - `index` Action：获取并显示所有购物车的信息。
  - `edit` Action：获取购物车及其订单，并允许支付或删除选中订单。
  - `create` Action：创建新购物车。
  - `update` Action：处理支付或删除选中订单的逻辑。
  - `destroy` Action：销毁购物车。

### 6. OrdersController
- **设计重点：** 订单控制器，处理订单的创建、编辑、支付和删除。
- **功能绑定：** 
  - `index` Action：获取并显示所有订单的信息。
  - `show` Action：显示单个订单的详细信息。
  - `new` Action：创建新订单，同时处理商品库存和用户余额的逻辑。
  - `edit` Action：允许用户编辑订单信息。
  - `create` Action：创建新订单，同时处理商品库存和用户余额的逻辑。
  - `update` Action：更新订单信息，如修改地址或数量。
  - `destroy` Action：删除订单。

### 商家功能

### 7. ShopsController
- **设计重点：** 商店控制器，处理商店的创建、编辑和删除。
- **功能绑定：** 
  - `index` Action：获取并显示当前商家所有商店的信息。
  - `new` Action：创建新商店，如果用户不是商家，则重定向到首页。
  - `create` Action：创建新商店。
  - `edit` Action：允许商家编辑商店信息。
  - `update` Action：更新商店信息。
  - `destroy` Action：尝试删除商店，捕捉外键约束异常，手动删除关联的订单，最后删除商店。

### 8. CommoditiesController
- **设计重点：** 商品控制器，处理商品的创建、编辑和删除。
- **功能绑定：** 
  - `index` Action：获取并显示当前商店所有商品的信息。
  - `show` Action：显示单个商品的详细信息。
  - `new` Action：创建新商品。
  - `create` Action：创建新商品。
  - `edit` Action：允许商家编辑商品信息。
  - `update` Action：更新商品信息。
  - `destroy` Action：删除商品，同时删除关联的订单。

这样，ShopsController 处理商店相关的逻辑，包括商店的创建、编辑和删除，而 CommoditiesController 处理商品的创建、编辑和删除，同时确保了删除商品时同时删除了关联的订单。

### 9. AddressesController
- **设计重点：** 地址控制器，处理顾客的地址信息，包括创建、编辑和删除。
- **功能绑定：** 
  - `new` Action：允许顾客创建新的收货地址。
  - `create` Action：保存新的收货地址。
  - `edit` Action：允许顾客编辑当前收货地址。
  - `update` Action：更新当前收货地址。
  - `destroy` Action：删除当前收货地址。

### 管理员功能

### 10. CategoriesController

- **设计重点：** 商品类别控制器，用于管理商品的分类信息，**管理员进行操作。**
- **功能绑定：**
  - `index` Action：显示所有商品类别。
  - `show` Action：显示特定商品类别的详细信息。
  - `new` Action：允许管理员创建新的商品类别。
  - `create` Action：保存新的商品类别。
  - `edit` Action：允许管理员编辑商品类别。
  - `update` Action：更新商品类别信息。
  - `destroy` Action：删除商品类别。

### 11. AdminsController

- **设计重点：** 管理员控制器，负责管理员相关功能。
- **功能绑定：**
  - `commodities` Action：显示所有商品信息。
  - `orders` Action：显示所有订单信息。
  - **同时可以查看当前所有已注册顾客，商家以及他们的所有信息。**
