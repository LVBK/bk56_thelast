class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:update,:destroy,:new,:create]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    respond_with(@question)
  end

  def new
    @question = Question.new user: current_user
    respond_with(@question)
  end

  def edit
    @question = Question.find(params[:id])
    if current_user != @question.user
       flash[:danger] = "u dont have permission."
       redirect_to root_url
    end
  end

  def create
    @question = Question.new(question_params.merge!({user: current_user}))
    @question.save
    respond_with(@question)
  end

  def update
    @question = Question.find(params[:id])
    if current_user == @question.user
    @question.update(question_params)
    end
    respond_with(@question)
  end

  def destroy
    @question = Question.find(params[:id])
    if current_user == @question.user
    @question.destroy
    respond_with(@question)
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit :title, :content
    end
end