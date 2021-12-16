# Frozen_string_literal: true

# Topic
class TopicsController < ApplicationController
  before_action :set_topic, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[create destroy]
  skip_before_action :verify_authenticity_token
  # protect_from_forgery prepend: true
  def index
    @topics = Topic.all
  end

  def new; end

  def destroy
    @topic.destroy if current_user.admin?
    respond_to do |format|
      format.json { head :no_content }
      format.html
    end
  end

  def show
    puts params[:topic_id]
  end

  def create
    @topic = Topic.new(topic_params)
    respond_to do |format|
      if @topic.save
        format.json { render json: @topic, status: :created }
        format.html { redirect_to topics_path, status: :ok, location: @topic }
      else
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:text, :name)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
