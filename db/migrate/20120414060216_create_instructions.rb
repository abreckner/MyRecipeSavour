class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.references :recipe
      t.integer :length_in_minutes
      t.text :content
      t.timestamps
    end
  end
end
