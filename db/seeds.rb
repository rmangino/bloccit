# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

###############################################################################

# Helpers

# Attempts to create a new model object of class model_class. options_hash
# should contain the same hash data passed to ActiveRecord::Base.new().
#
# find_by_symbol should be the same symbol you'd pass into find_by(), 
# e.g. Post.find_by(title: data). The data value comes from 
# options_hash[find_by_symbol]. 
def create_unique_entity_in(model_class, options_hash, find_by_symbol)
  unique_item = model_class.new(options_hash)
  puts find_by_symbol => unique_item[find_by_symbol]
  item        = model_class.find_by(find_by_symbol => unique_item[find_by_symbol])

  if !item
    # the item doesn't already exist so save it to the db
    unique_item.save
    item = unique_item    
  else
    puts "Unique #{model_class.to_s.downcase} already exists"
  end

  item
end

###############################################################################

# Create Posts
50.times do
  Post.create!(title:  Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
end

# Create a unique post
post_data = { title:  "A unique post title", body: "A unique post body" }
post = create_unique_entity_in(Post, post_data, :title)

###############################################################################

# Create Comments
100.times do
  Comment.create!(post: Post.all.sample, body: Faker::Lorem.paragraph)
end

# Create a unique comment on post
create_unique_entity_in(Comment, { post:  post, body: "A unique comment body" }, :body)

###############################################################################

# Create Advertisements

20.times do
  Advertisement.create!(title: Faker::Lorem.sentence, 
                        copy:  Faker::Lorem.paragraph, 
                        price: Faker::Number.number(4))
end

# Create a unique advertisement

advert_data = { title: "A unique advertisement title", 
                copy:  "A unique advertisement copy",
                price: 42 }
create_unique_entity_in(Advertisement, advert_data, :title)

###############################################################################

# Create Questions

20.times do
  Question.create!(title: Faker::Lorem.sentence, 
                   body:  Faker::Lorem.paragraph, 
                   resolved: [true, false].sample)
end

# Create a unique question

question_data = { title: "A unique question title", 
                  body:  "A unique question body",
                  resolved: false }
create_unique_entity_in(Question, question_data, :title)

# Report results

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisments created"
puts "#{Question.count} questions created"