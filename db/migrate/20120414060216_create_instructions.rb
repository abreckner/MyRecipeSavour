class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|

      t.timestamps
    end
  end
end
