module RecipesHelper
  def link_tags(tags)
    tag_links = ""
    tags.each do |tag|
      unless tag == tags.last
        tag_links += "#{link_to tag.name, recipes_path(:tag => tag.name)}, "
      else
        tag_links += link_to tag.name, recipes_path(:tag => tag.name)
      end
    end
    tag_links.html_safe
  end
end
