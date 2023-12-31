
# Build Steps

## Database

### 思考所有的数据库,以及关系,画好ERD图

1. Users ( devise, store user info)

   - id: integer
   - email: string
   - password: string
   - is_admin: boolean

2. Addresses(Store user addresses):

   - id: integer
   - user_id: integer (references Users)
   - address_line_1: string
   - address_line_2: string
   - city: string
   - province_id: integer (references Province)
   - postal_code: string
   - created_at: datetime
   - updated_at: datetime

3. Province(Store provinces):

   - id: integer
   - name: string
   - tax_rate: decimal
   - created_at: datetime
   - updated_at: datetime

4. Products(Store products):

   - id: integer
   - title: string
   - description: text
   - authors: string
   - average_rating: decimal
   - isbn: string
   - isbn13 :string
   - published_year: integer
   - created_at: datetime
   - updated_at: datetime
   - num_pages: integer
   - ratings_count: integer
   - stock: integer
   - price: decimal
   - thumbnail: string (url link from books CSV)

5. Categories(Store product categories):

   - id: integer
   - name: string
   - created_at: datetime
   - updated_at: datetime

6. Orders(Store orders):

   - id: integer
   - user_id: integer (references Users)
   - total_amount: decimal
   - status: string
   - created_at: datetime
   - updated_at: datetime
   - taxes: decimal

7. OrderItems(Store order items)

   - id: integer
   - order_id: integer (references Orders)
   - product_id: integer (references Products)
   - quantity: integer
   - price: decimal
   - created_at: datetime
   - updated_at: datetime

8. Categories_Products (Join table):
   - category_id: integer (references Categories)
   - product_id: integer (references Products)

## Models

先利用 devise 生成 User model
再利用 ActiveAdmin 生成 Admin (注意不要使用 devise,会冲突)
 (这一步注意,admin 和 user 是 2 套登录系统.本来想做一套,还是分开了.因为不好处理.本身 admin 也最好有自己的后台管理系统)
再利用 rails g model 生成Product 和 Category Models
这里注意,因为 Category 和 Product 是多对多关系,所以需要生成 Categories_Products join table

处理好这些之后,需要进行 seeds.rb 文件
学会如何从 CSV 文件中读取数据,并且存入数据库中
以及设置一些筛选(我筛选部分还可以学习,感觉做的不够好)
我对拿到的数据库进行了二次处理,删除了一些字段为 0 或者 url 不正确的数据 以正确显示图片
÷
### 做 Active Admin 基础功能

对 Product 和 Category 进行 CRUD 操作 
对 User 进行 CRUD 操作
增加对 Product Images 的上传功能


### 基础视图
Product index 页面 (显示所有的书籍)
Product show 页面 (显示单本书籍)
Category index 页面 (显示Top 20 分类)
sidebar (显示Top10 Categories)

## 基础功能

### AWS 分支 图片处理

首先学会如何设置 AWS S3 bucket (需要设置用户,S3 权限 基础设置)
其次学会在 rails 如何 configurer AWS S3 bucket (每个字段都要检查)
需要理解 Active Storage 如何处理图片上传,以及上传到 AWS S3 bucket 的流程 和格式
最后学会如何在 rails 中使用 AWS S3 bucket 的图片
如何在 ActiveAdmin 中使用 AWS S3 bucket 的图片 , 如何自动压缩图片, 如何在 View 中使用 AWS S3 bucket 的图片

基本完成了图片处理

### Search 分支 搜索功能

实现分类搜索 

### Cart 分支 订单功能

实现购物车功能

### Order 分支 订单功能

实现订单功能

### Bootstrap 分支 前端美化

实现前端美化

### Stripe 分支 支付功能 (还未实现)

### Mailgun 分支 邮件功能 (还未实现)


