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
    if current_user==nil then redirect_to '/users/sign_in'; return end
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
    if current_user==nil then redirect_to '/users/sign_in';  return end
      if current_user.id!=@question.user_id then redirect_to '/questions/'; return end
    @question.destroy
    respond_with(@question)
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :content, :user_id)
    end
end