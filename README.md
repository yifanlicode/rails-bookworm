## Database

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
