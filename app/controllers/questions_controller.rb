class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :update, :edit, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Question was saved."
      redirect_to @question
    else
      flash[:error] = "There was an error saving the question. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(question_params)
      flash[:notice] = "Question was updated."
      redirect_to @question
    else
      flash[:error] = "There was an error saving the question. Please try again."
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = "Question deleted."
    redirect_to questions_url
  end

private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :resolved)
  end

end
