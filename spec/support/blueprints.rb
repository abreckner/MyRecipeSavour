require 'machinist/active_record'

Recipe.blueprint do
  name {'Pasta'}
  description {'Yummy'}
  num_people {4}
end

Recipe.blueprint(:complete) do
  name {'Pasta'}
  description {'Yummy'}
  num_people {4}
  instructions(2)
  ingredients(3)
end

Instruction.blueprint do
  content {'Place egg in boiling water'}
  length_in_minutes {'5'}
end

Ingredient.blueprint do
  content {'Water'}
  amount {'5 litres'}
end

Site.blueprint do
  domain {'www.taste.com.au'}
  title_selector {'h1'}
  method_selector {'#methods li'}
  ingredient_selector {'#ingredients li'}
  image_selector {'.image'}
end

User.blueprint do
  email {'test@test.com'}
  password {"qwerty"}
end

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end
