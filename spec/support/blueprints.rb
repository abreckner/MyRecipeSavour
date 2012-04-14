require 'machinist/active_record'

Recipe.blueprint do
  name Pasta
  description Yummy
  num_people 4
end

Instruction.blueprint do
  recipe {Recipe.make}
  content Here is some content
end

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end
