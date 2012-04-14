module FieldSplitter
  def multi_save(field_string = '', recipe)
    field_array = field_string.split(/\r\n|\n/)
    field_array.each do |instruction_content|
      inst = self.new(:content => instruction_content)
      recipe.instructions << inst
      recipe.save
    end
  end
end