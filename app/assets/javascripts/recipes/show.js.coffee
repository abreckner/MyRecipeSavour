tag_link_template = """
  <a href="/recipes?tag=<%= tag %>"><%= tag %></a>
"""

link_tag = (tag) ->
  _.template(tag_link_template, {tag: tag})

edit_categories_click_handler = -> 
  $(this).hide()
  $('#js_category_display').hide()
  $('#js_category_input').show()

save_categories_click_handler = (e)->
  e.preventDefault();
  recipe_id = $('#recipe_id').val()
  recipe_tag_list = $('#recipe_tag_list').val()
  $.ajax "/recipes/#{recipe_id}.json",
    type: 'PUT'
    dataType: 'JSON'
    data: {'recipe' : {'tag_list' : recipe_tag_list}}
    error: (jqXHR, textStatus, errorThrown) ->
      $('body').append "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
      link_tags = data.tags.map(link_tag).join(', ')
      $('#js_category_input').hide()
      $('#js_category_display').html(link_tags)
      $('#js_category_display').show()
      $('#js_edit_categories').show()

$ ->
  $('#js_edit_categories').live 'click', edit_categories_click_handler
  $('#js_save_categories').live 'click', save_categories_click_handler
  $('#js_category_form').live 'submit', save_categories_click_handler
    