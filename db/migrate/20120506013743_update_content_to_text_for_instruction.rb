class UpdateContentToTextForInstruction < ActiveRecord::Migration
  def change
    change_column :instructions, :content, :text
  end
end
