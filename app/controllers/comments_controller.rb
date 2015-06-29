class CommentsController < ApplicationController

  # Try to save a new comment
  def create
    @comment = current_user.comments.build(comment_params)
    @post    = @comment.post
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end  

end
