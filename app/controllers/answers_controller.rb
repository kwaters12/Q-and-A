class AnswersController < ApplicationController
  before_action :find_question, except: [:show]

  def index
    @answers = Answer.all    
  end


  def create
    @answer      = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to @question, notice: "Thanks for your answer"
  end

  def show

    @answer = Answer.find(params[:id])
    @question = @answer.question
    @commentable = @answer
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end