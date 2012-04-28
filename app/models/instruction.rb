class Instruction < ActiveRecord::Base
  attr_accessible :content, :length_in_minutes
  belongs_to :recipe

  def self.multi_save(instructions = '', recipe)
    instructions_contents = instructions.split(/\r\n|\n|\r/)
    instructions_contents.each do |instruction_content|
      inst = self.new(:content => instruction_content.strip) if instruction_content.strip.length > 0
      recipe.instructions << inst unless inst.nil?
      recipe.save
    end
  end

  def formatted_content
    content
  end
end
