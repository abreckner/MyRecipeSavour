class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.references :recipe
      t.string :content
      t.timestamps
    end
  end
end
