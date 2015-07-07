class CommentsController < ApplicationController

  # Try to save a new comment
  def create
    find_post
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was saved."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    redirect_to [@post.topic, @post]
  end

  def destroy
    find_post
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was deleted."
    else
      flash[:error] = "Comment couldn't be deleted"
    end

    respond_to do |format|
      format.html # normal response
      format.js   # allows the controller to render an *.js.erb instead
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

end
