class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :edit]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  

  respond_to :html

  def index
    @answers = Answer.all
    respond_with(@answers)
  end

  def show
    respond_with(@answer)
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
    respond_with(@answer)
  end

  def edit
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question_id = @question.id
    @answer.user_id = current_user.id
    @answer.save
    redirect_to @question
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    @answer.destroy
    respond_with(@answer)
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:question_id, :title, :description)
    end
end
