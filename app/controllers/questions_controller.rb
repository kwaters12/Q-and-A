class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @questions = Question.page(params[:page]).per_page(9)
    @num_questions = Question.total
    @questions.each do |question|
      @answers = question.answers
    end
    @answers
  end

  def new
    @question = Question.new
  end

  def create
    question = current_user.questions.new(question_params)
    if question.save
      UserMailer.thank_you(question).deliver
      redirect_to root_url, notice: "Thank you!"
    else
      flash.now[:error] = "Sorry, your question can not be added"
      render :new
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer  = Answer.new
    @answers = @question.answers
    @question.save
  end

  private

  def question_params
    params.require(:question).permit(:topic, :body)
  end

end