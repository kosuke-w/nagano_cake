class RenameShippngCostColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :shippng_cost, :shipping_cost
  end
end
