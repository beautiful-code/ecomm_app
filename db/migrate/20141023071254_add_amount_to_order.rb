class AddAmountToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :amount, :integer, :default => 0
  end
end
