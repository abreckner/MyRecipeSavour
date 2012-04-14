class Instruction < ActiveRecord::Base
  attr_accessible :content
  belongs_to :recipe

  def self.multi_save(instructions = '', recipe)
    instructions_contents = instructions.split(/\r\n|\n/)
    instructions_contents.each do |instruction_content|
      inst = self.new(:content => instruction_content)
      recipe.instructions << inst
      recipe.save
    end
  end
end
