class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :commands do |t|
      t.string :date
      t.string :amount
      t.string :paypal_order_id
      t.string :status
      t.references :client, index: true
      t.timestamps
    end
  end
end
