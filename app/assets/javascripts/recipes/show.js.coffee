ingredient_select_handler = -> 
  ingredient = $(this).parents('.ingredient')
  ingredient_id = ingredient.attr('data-ref')
  amount = ingredient.find('.amount')
  if amount.val() == ''
    caret = $(this).caret()
    amount_text = caret.text  
    amount.val amount_text
    original_value = $(this).val()
    first_part = original_value.slice(0, caret.start)
    second_part = original_value.slice(caret.end, original_value.length)
    content = $.trim(first_part + second_part)
    $(this).val content

    $.ajax "/ingredients/#{ingredient_id}.json",
      type: 'PUT'
      dataType: 'JSON'
      data: {'ingredient' : {'content' : content, 'amount' : amount_text}}
      error: (jqXHR, textStatus, errorThrown) ->
        $('body').append "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        $('body').append "Successful AJAX call: #{data}"

add_ingredient_handler = ->
  $('.new_ingredient input').show();

save_ingredient = ->
  ingredient = $(this).parents('.new_ingredient')
  amount = ingredient.find('.amount').val()
  ingredient_type = $(this).val()
  recipe_id = $('#recipe_id').val()

  $.ajax "/ingredients.json",
      type: 'POST'
      dataType: 'JSON'
      data: {'ingredient' : {'content' : ingredient_type, 'amount' : amount}, 'recipe_id' : recipe_id}
      error: (jqXHR, textStatus, errorThrown) ->
        $('body').append "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        $('body').append "Successful AJAX call: #{data}"
        ingredients_table = $('#ingredients_table tbody')
        ingredients_table.append _.template(ingredient_row_template, {ingredient: data})
        $('.new_ingredient input').hide();
        $('.new_ingredient input').val(''); 

ingredient_row_template = """
  <tr class="ingredient" data-ref="<%=ingredient.id%>">
    <td>
      <input type="text" value="<%= ingredient.amount %>" class="amount" />
    </td>
    <td>
       <input type="text" value="<%= ingredient.content %>" class="ingredient_type" />
    </td>
    <td>
      <button type="button" class="delete_ingredient" data-ref="<%=ingredient.id%>">Delete Ingredient</button>
    </td>
  </tr>"""

$ ->
  $('.ingredient_type').live 'select', ingredient_select_handler
  $('#add_ingredient').bind 'click', add_ingredient_handler
  $('.new_ingredient_type').live 'blur', save_ingredient 
    