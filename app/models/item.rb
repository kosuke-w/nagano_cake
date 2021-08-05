class Item < ApplicationRecord
  attachment :image

  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  def add_tax_price
    (self.price * 1.10).round
  end

end
