class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, confirm: 1, producting: 2, stand_by: 3, sending: 4 }
  
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
