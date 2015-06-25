class SummariesController < ApplicationController
  before_action :find_post

  def show
    @summary = @post.summary
  end

  def new
    @summary = Summary.new
    @summary.post = @post
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
    @summary = @post.summary
  end

  def update
    @summary = @post.summary
    if @summary.update_attributes!(strong_params)
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

  def find_post
    @post  = Post.find(params[:post_id])
  end  

  def strong_params
    params.require(:summary).permit(:description)
  end
end
