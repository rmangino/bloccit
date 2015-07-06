class TopicsController < ApplicationController
  before_action :find_topic, only: [:show, :update, :edit, :destroy]

  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def show
    authorize @topic
    # We'll display the posts associated with this topic
    #
    # Use eager loading to pull in the associated user and comments at the same time as posts
    # http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations
    @posts = @topic.posts
                   .includes(:user)
                   .includes(:comments)
                   .paginate(page: params[:page]).per_page(100)
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

  def destroy
    authorize @topic

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully/."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end

private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end
end
