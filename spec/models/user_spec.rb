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

end # describe User