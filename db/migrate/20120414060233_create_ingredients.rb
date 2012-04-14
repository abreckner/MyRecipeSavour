class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.references :recipe
      t.string :amount
      t.string :content
      t.timestamps
    end
  end
end
