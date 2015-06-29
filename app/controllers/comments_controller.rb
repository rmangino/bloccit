class CommentsController < ApplicationController

  # Try to save a new comment
  def create
    find_topic_and_post
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was saved."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    redirect_to [@topic, @post]
  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end  

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def find_topic_and_post
    find_topic
    @post = @topic.posts.find(params[:post_id])
  end

end
