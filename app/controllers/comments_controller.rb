class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
  end

  def create
    @comment = Comment.create({field: params[:field], user_id: current_user.id, post_id: params[:post_id]})
    post_id = @comment.post_id
    redirect_to "/centers/#{center_id}"
  end

  def edit
  end

  def update
  end
end

