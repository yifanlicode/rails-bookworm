ActiveAdmin.register Order do
    index do
      selectable_column
      id_column
      column :user
      column :created_at
      column "Products" do |order|
        ul do
          order.order_items.each do |order_item|
            li "#{order_item.product.title} (Quantity: #{order_item.quantity})"
          end
        end
      end
      column :total_amount
      actions
    end
  
    # 可以添加其他自定义的配置和操作
  end
  