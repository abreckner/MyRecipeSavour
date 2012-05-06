module RecipesHelper
  def link_tags(tags)
    tags.map{|tag| link_to(tag.name, recipes_path(:tag => tag.name))}.join(', ').html_safe
  end
end
