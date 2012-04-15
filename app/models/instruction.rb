class Instruction < ActiveRecord::Base
  attr_accessible :content, :length_in_minutes
  belongs_to :recipe

  def self.multi_save(instructions = '', recipe)
    instructions_contents = instructions.split(/\r\n|\n/)
    instructions_contents.each do |instruction_content|
      if instruction_content.include? '|'
        line_items = instruction_content.split('|')
        inst = self.new(:content => line_items[0].strip, :length_in_minutes => line_items[1].match(/.+\d/)[0])
      else
        inst = self.new(:content => instruction_content.strip)
      end
      recipe.instructions << inst
      recipe.save
    end
  end

  def formatted_content
    unless length_in_minutes.blank?
      "#{content} | #{length_in_minutes} minute(s)"
    else
      content
    end
  end
end
