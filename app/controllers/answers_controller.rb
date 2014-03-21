class AnswersController < ApplicationController
  before_action :find_question, except: [:show]

  def index
    @answers = Answer.all    
  end


  def create
    @answer      = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      respond_to do |format|
        format.html {redirect_to @question, notice: "Thanks for your answer"}
        format.js 
      end
    else
      render :new
    end      
  end

  def show

    @answer = Answer.friendly.find(params[:id])
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
    @question = Question.friendly.find(params[:question_id])
  end
end