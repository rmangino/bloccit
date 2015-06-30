class VotesController < ApplicationController
  
  before_action :find_post_and_vote

  def up_vote
    update_vote!(1)

    # http://apidock.com/rails/ActionController/Base/redirect_to
    redirect_to :back
  end

  def down_vote
    update_vote!(-1)

    # http://apidock.com/rails/ActionController/Base/redirect_to
    redirect_to :back
  end

private

  def find_post_and_vote
    @post = Post.find(params[:post_id])
    
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote!(new_value)
    if @vote
      authorize @vote, :update?

      current_points = @post.points
      @vote.update_attribute(:value, current_points + new_value)
    else
      @vote = current_user.votes.build(value: new_value, post: @post)

      authorize @vote, :create?

      @vote.save
    end
  end

end