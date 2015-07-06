require "rails_helper"

describe "Vising profiles" do

  include TestFactories

  before do
    @user = authenticated_user
    @post = associated_post(user: @user)

    @comment = Comment.new(user: @user, post: @post, body: "A comment")
    allow( @comment ).to receive( :send_favorite_emails )
    @comment.save!
  end

  describe "not signed in" do

    it "shows profile" do
      visit user_path(@user)

      expect( current_path ).to eq( user_path(@user) )

      expect( page ).to have_content( @user.name )
      expect( page ).to have_content( @post.title )
      expect( page ).to have_content( @comment.body )
    end

  end # describe "not signed in"

  describe "user has signed in" do

    before do
      # We can't just overwrite @user here because the outermost 'before' block
      # has already created a user which has an associated post and comment. Instead,
      # just confirm and save @user so that we can login with that user.
      #
      # @user = FactoryGirl.create(:user)
      @user.confirmed_at = Time.now
      @user.save

      login_as( @user, :scope => :user )
    end

    after do
      Warden.test_reset!
    end

    it "shows profile" do
      visit user_path(@user)

      expect( current_path ).to eq( user_path(@user) )

      expect( page ).to have_content( @user.name )
      expect( page ).to have_content( @post.title )
      expect( page ).to have_content( @comment.body )
    end

  end # describe "not signed in"

end # describe "Vising profiles"