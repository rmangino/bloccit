require 'rails_helper'

describe VotesController do

  include TestFactories
  include Devise::TestHelpers

  describe "#up_vote" do
    it "add an upvote to the post" do
      # needed because #up_vote uses 'redirect_to :back'
      request.env["HTTP_REFERER"] = '/'
      
      @user = authenticated_user
      @post = associated_post
      sign_in @user # Devise test method

      expect {
        post( :up_vote, post_id: @post.id ).to change( @post.up_votes).by 1
      }
    end
  end
  
end # describe VotesController