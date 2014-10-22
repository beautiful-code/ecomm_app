class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :units
      t.integer :cost
      t.string :manufacturer

      t.timestamps
    end
  end
end
