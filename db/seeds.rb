# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create Posts
50.times do
  Post.create!(title:  Faker::Lorem.sentence, body:   Faker::Lorem.paragraph)
end

# Create a unique post
unique_post = Post.new(title: "A unique title", body: "A unique post body")
post = Post.find_by(title: unique_post.title)
if !post
  # the post doesn't already exist so save it to the db
  unique_post.save
  puts "Unique post saved"
  post = unique_post
else
  puts "Unique post already exists"
end

posts = Post.all

# Create Comments
100.times do
  Comment.create!(post: posts.sample, body: Faker::Lorem.paragraph)
end

# Create a unique comment on post
unique_comment = Comment.new(post: post, body: "A unique comment body")
comment = Comment.find_by(body: unique_comment.body)
if !comment
  # the comment doesn't already exist so save it to the db
  unique_comment.save
  puts "Unique comment saved"
  comment = unique_comment
else
  puts "Unique comment already exists"
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"