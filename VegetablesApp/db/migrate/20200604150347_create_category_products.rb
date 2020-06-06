class CreateCategoryProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :category_products do |t|
      t.references :product
      t.references :category
      t.timestamps
    end
  end
end
