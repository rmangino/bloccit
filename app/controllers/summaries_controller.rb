class SummariesController < ApplicationController
  before_action :find_summary, except: [:new, :create]
  before_action :find_post_and_topic

  def show
    # nothing to see here...
  end

  def new
    @summary = Summary.new
  end

  def create
    @summary = Summary.create(strong_params)
    @summary.post = @post
    if @summary.save
      flash[:notice] = "Summary was saved."
      redirect_to [@topic, @post, @summary]
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :new
    end
  end

  def edit
    # nothing to see here...
  end

  def update
    if @summary.update_attributes(strong_params)
      flash[:notice] = "Summary was updated."
      redirect_to [@topic, @post, @summary]
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :edit
    end
  end

  # def destroy
  # end

private

  def find_summary
    @summary = Summary.find(params[:id])
  end  

  def find_post_and_topic
    @post  = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
  end  

  def strong_params
    params.require(:summary).permit(:description, :topic_id, :post_id)
  end
end
