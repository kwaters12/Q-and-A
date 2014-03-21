class Api::V1::QuestionsController < ApplicationController
  before_filter :restrict_access

  def index
    @questions = Question.all
  end
  def show
    @question = Question.find(params[:id])
  end
  def create
    render json: @question = Question.new(question_params)
    @question.save
  end

  private

  def restrict_access
    # @api_key ||= ApiKey.find_by_access_token(params[:access_token])
    # head :unauthorized unless @api_key.present?

    authenticate_or_request_with_http_token do |token, options|
      @api_key ||= ApiKey.find_by_access_token(token)
      @api_key.present?
    end
  end

  def api_user
    @api_user ||= @api_key.user
  end

  def question_params
    params.require(:question).permit(:topic, :body)
  end

end