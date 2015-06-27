class TopicsController < ApplicationController
  before_action :find_topic, only: [:show, :update, :edit, :destroy]

  def index
    @topics = Topic.paginate(page: params[:page])
    authorize @topics
  end

  def show
    authorize @topic
    # We'll display the posts associated with this topic
    @posts = @topic.posts.paginate(page: params[:page]).per_page(100) 
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def update
    authorize @topic
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :edit
    end
  end

  def edit
    authorize @topic
  end

private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end  
end
