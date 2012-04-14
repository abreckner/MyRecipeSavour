$ ->
  $('.ingredient_item').bind 'select', -> 
    ingredient = $(this).parents('.ingredient')
    amount = ingredient.find('.amount')
    caret = $(this).caret()
    amount.val caret.text
    original_value = $(this).val()
    first_part = original_value.slice(0, caret.start)
    second_part = original_value.slice(caret.end, original_value.length)
    $(this).val $.trim(first_part + second_part)