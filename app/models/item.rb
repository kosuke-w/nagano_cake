class Item < ApplicationRecord
  attachment :image

  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre, presence: true
  validates :image, presence: true
  validates :is_active, inclusion: { in: [true, false]}

  def add_tax_price
    (self.price * 1.10).round
  end

end
