class PostsController < ApplicationController
  before_action :post_params, except: [:create, :new]
 
  # Not needed because Post resources are nested within Topic resources. Posts
  # are displayed wrt a Topic.
  # def index
  #   @posts = Post.all
  #   authorize @posts
  # end

  def show
    # Nothing to see here...
  end

  # Create an empty post
  def new
    @post = Post.new
    @post.summary = Summary.new
    find_topic
    authorize @post
  end

  # Try to save a new post
  def create
    @post = current_user.posts.build(strong_params)
    @post.topic = @topic
    authorize @post
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update_attributes(strong_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

private

  def strong_params
    params.require(:post).permit(:title, :body, summary_attributes: [:id, :description])
  end

  def post_params
    @post  = Post.find(params[:id])
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end  
end
