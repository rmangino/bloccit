require 'rails_helper'

describe User do

  include TestFactories

  describe "#favorited(post)" do

    before :each do
      @post1 = associated_post
      @post2 = associated_post
      @user = authenticated_user
    end

    it "returns 'nil' if the user has not favorited the post" do
      expect( @user.favorited(@post1) ).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      new_favorite = @user.favorites.create(post: @post1)

      expect( @user.favorited(@post1) ).to eq(new_favorite)
    end

    it "returns `nil` if the user has favorited another post" do
      @user.favorites.create(post: @post1)

      expect( @user.favorited(@post2) ).to be_nil
    end

  end # #favorited(post)

  describe ".top_rated" do

    before do
      @user1 = create(:user)
      post = create(:post, user: @user1)
      create(:comment, user: @user1, post: post)

      @user2 = create(:user)
      post = create(:post, user: @user2)
      2.times { create(:comment, user: @user2, post: post) }
    end

    it "returns users ordered by comments + posts" do
      expect( User.top_rated ).to eq( [@user2, @user1] )
    end

    it "stores a `posts_count` on user" do
      users = User.top_rated

      expect( users.first.posts_count ).to eq( 1 )
    end

    it "stores a `comments_count` on user" do
      users = User.top_rated

      expect( users.first.comments_count ).to eq( 2 )
    end

  end # describe ".top_rated"

  describe ":user_with_post_and_comment factory" do

    before do
      @user = create(:user_with_post_and_comment)
    end

    it "has one post" do
      expect( @user.posts.count ).to eq( 1 )
    end

    it "has one comment" do
      expect( @user.comments.count ).to eq( 1 )
    end

    it "has the correct post" do
      expect( @user.posts.first.title ).to eq( "Post Title" )
      expect( @user.posts.first.body ).to  eq( "Post bodies must be pretty long." )
    end

    it "has the correct comment" do
      expect( @user.comments.first.body ).to eq( "This is a new comment." )
    end

  end # describe ":user_with_post_and_comment factory"

end # describe User