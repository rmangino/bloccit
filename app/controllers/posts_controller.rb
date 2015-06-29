class PostsController < ApplicationController
  before_action :find_topic

  # Not needed because Post resources are nested within Topic resources. Posts
  # are displayed wrt a Topic.
  # def index
  #   @posts = Post.all
  #   authorize @posts
  # end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  # Create an empty post
  def new
    @post = Post.new
    authorize @post
    authorize @comment
  end

  # Try to save a new post
  def create
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post
    authorize @comment
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

private

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end  
end
