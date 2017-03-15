class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    total = 0
    line_items.map do |line_item|
      total += line_item.item.price * line_item.quantity
    end
    total
  end

  def add_item(item_id)
    if li = line_items.find_by(item_id: item_id)
      li.quantity += 1
    else
      li = line_items.build(item_id: item_id)
    end
    li
  end

  def checkout_cart
    line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    user.checkout_current_cart
  end
end
