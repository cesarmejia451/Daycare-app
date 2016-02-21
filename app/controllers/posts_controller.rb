class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    # @comments = Comment.all

  end

  def new
  end

  def create
    @post = Post.create({title: params[:title], user_id: current_user.id, center_id: params[:center_id]})
    center_id = @post.center_id
    redirect_to "/centers/#{center_id}"

  end 

end
