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
  #qputs find_by_symbol => unique_item[find_by_symbol]
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

def create_user(name, email, password, role)
  user = User.new(name: name, email: email, password: password, role: role)
  user.skip_confirmation!
  user.save!
end

###############################################################################

# Create Users
admin     = create_user('Admin User', 'admin@example.com', 'helloworld', 'admin')
moderator = create_user('Moderator User', 'moderator@example.com', 'helloworld', 'moderator')
member    = create_user('Member User', 'member@example.com', 'helloworld', 'member')

users = User.all

###############################################################################

# Create Topics
15.times do
  Topic.create!(name:        Faker::Lorem.sentence,
                description: Faker::Lorem.paragraph)
end

topics = Topic.all

###############################################################################

# Create Posts
50.times do
  post = Post.create!(user:  users.sample, 
                      title: Faker::Lorem.sentence,
                      body:  Faker::Lorem.paragraph,
                      topic: topics.sample)

  # set the created_at to a time within the past year
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  post.update_rank
end

# Create a unique post
post = Post.create!(user:  users.sample,
                    topic: topics.sample,
                    title: "A unique post title", 
                    body:  "A unique post body. A unique post body. A unique post body." )
post.save!

# For ease of testing create a bunch of posts on the first topic
200.times do
  Post.create!(user:  users.sample, 
               title: Faker::Lorem.sentence,
               body:  Faker::Lorem.paragraph,
               topic: topics.first)
end  

###############################################################################

# Create Comments
100.times do
  Comment.create!(user: users.sample,
                  post: Post.all.sample, 
                  body: Faker::Lorem.paragraph)
end

# Create a unique comment on post
create_unique_entity_in(Comment, { post: post, body: "A unique comment body", user: post.user }, :body)

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
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisments created"
puts "#{Question.count} questions created"