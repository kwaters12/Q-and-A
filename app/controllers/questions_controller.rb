class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @questions = Question.page(params[:page]).per_page(9)
    @num_questions = Question.total
    @questions.each do |question|
      @answers = question.answers
    end
    @answers
    respond_to do |format|
      format.html {render}
      format.json { render json: @questions.all }
    end
  end

  def new
    @question = Question.friendly.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      # UserMailer.thank_you(@question).deliver
      redirect_to root_url, notice: "Thank you!"
    else
      flash.now[:error] = "Sorry, your question can not be added"
      render :new
    end
  end

  def edit
    @question = Question.friendly.find(params[:id])
  end

  def update
    @question = Question.friendly.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to question_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.friendly.find(params[:id])
    if @question.user == current_user
      @question.destroy
      redirect_to questions_path, notice: "Question Deleted Successfully"
    else
      redirect_to questions_path, notice: "Hey man, don't delete your buddy's question."      
    end
  end    

  def show
    @question = Question.friendly.find(params[:id])
    @answer  = Answer.new
    @answers = @question.answers
    @question.save
    @commentable = @question
    @comments = @commentable.comments
    @comment = Comment.new
  end

  private

  def question_params
    params.require(:question).permit([:topic, :body])
  end

end