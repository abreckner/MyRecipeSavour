require 'machinist/active_record'

Recipe.blueprint do
  name {'Pasta'}
  description {'Yummy'}
  num_people {4}
end

Instruction.blueprint do
  recipe {Recipe.make}
  content {'Place egg in boiling water'}
  length_in_minutes {'5'}
end

Ingredient.blueprint do
  recipe {Recipe.make}
  content {'Water'}
  amount {'5 litres'}
end

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end
