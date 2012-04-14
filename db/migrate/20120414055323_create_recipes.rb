class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.references :user
      t.string :name
      t.string :description
      t.integer :num_people
      t.timestamps
    end
  end
end
