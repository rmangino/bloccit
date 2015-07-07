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

  # describe ".top_rated" do

  #   before do
  #     @user1 = create(:user)
  #     post = create(:post, user: @user1)
  #     create(:comment, user: @user1, post: post)

  #     @user2 = create(:user)
  #     post = create(:post, user: @user2)
  #     2.times { create(:comment, user: @user2, post: post) }
  #   end

  #   it "returns users ordered by comments + posts" do
  #     expect( User.top_rated ).to eq( [@user2, @user1] )
  #   end

  #   it "stores a `posts_count` on user" do
  #     users = User.top_rated

  #     expect( users.first.posts_count ).to eq( 1 )
  #   end

  #   it "stores a `comments_count` on user" do
  #     users = User.top_rated

  #     expect( users.first.comments_count ).to eq( 2 )
  #   end

  # end # describe ".top_rated"

end # describe User