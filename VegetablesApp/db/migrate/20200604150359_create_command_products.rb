class CreateCommandProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :command_products do |t|
      t.references :product, index :true
      t.references :command, index :true
      t.timestamps
    end
  end
end
