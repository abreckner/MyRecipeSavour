ingredientSelectHandler = -> 
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


$ ->
  $('.ingredient_item').bind 'select', ingredientSelectHandler 
    