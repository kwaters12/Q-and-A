class AnswersController < ApplicationController
  before_action :find_question

  def index
    @answers = Answer.all
  end


  def create
    @answer      = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to @question, notice: "Thanks for your answer"
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end