class PostsController < ApplicationController
  def index
    @posts = policy_scope(Post)
    #@posts = Post.all
    #authorize @posts
  end

  def show
    @post = Post.find(params[:id])
  end

  # Create an empty post
  def new
    @post = policy_scope(Post.new)
    #@post = Post.new
    #authorize @post
  end

  # Try to save a new post
  def create
    @post = policy_scope(current_user.posts.build(params.require(:post).permit(:title, :body)))
    #@post = current_user.posts.build(params.require(:post).permit(:title, :body))
    #authorize @post
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = policy_scope(Post.find(params[:id]))
    #@post = Post.find(params[:id])
    #authorize @post
  end

  def update
    @post = policy_scope(Post.find(params[:id]))
    #@post = Post.find(params[:id])
    #authorize @post
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
end
