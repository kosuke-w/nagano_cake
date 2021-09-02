class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :payment_method, presence: true
  validates :address, presence: true

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }

  enum status: { 入金待ち: 0, 入金確認: 1, 制作中: 2, 発送準備中: 3, 発送済み: 4 }

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

  def subtotal
    item.add_tax_price * amount
  end

end
