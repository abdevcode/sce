class CreateCommandProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :command_products do |t|
      t.integer :quantity
      t.references :product
      t.references :command
      t.timestamps
    end
  end
end
