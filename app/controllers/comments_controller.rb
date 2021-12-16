# Frozen_string_literal: true

# Comment
class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: %i[show destroy]
  before_action :authenticate_user!, only: %i[create destroy]

  def index
    @comments = Comment.where(topic_id: params[:topic_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.topic_id = params[:topic_id]
    respond_to do |format|
      if @comment.save!
        format.json { render json: @comment, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy if permission(params[:id])
    respond_to do |format|
      format.json { render json: @comment, status: :created }
      format.html
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:topic_id, :text)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def permission(id)
    current_user.admin? || (current_user.email == Comment.find(id).user.email)
  end
end
