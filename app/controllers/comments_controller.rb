class CommentsController < ApplicationController
  before_action :require_authenticate
  before_action :find_post
  before_action :find_comment, only: [:show, :edit, :update, :destroy]


  def index
    @comments = @post.comments
  end

  def show
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @post
    else
      render action: 'posts#show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @commment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end
