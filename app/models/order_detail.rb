class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum product_status: { incapable: 0, waiting: 1, producting: 2, finish: 3}

end
