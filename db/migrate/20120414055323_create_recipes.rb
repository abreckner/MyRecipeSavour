class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.int :num_people
      t.timestamps
    end
  end
end
