class CommentsController < ApplicationController
  before_action :set_comment, only: [:create, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]


  def create
    @comment = @blog.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to blog_path(@blog)
    end
  end


  def destroy
    @comment.destroy
    redirect_to blog_url(@blog)
  end

  private
  def set_comment
    @blog = Blog.find(params[:blog_id])
  end

  def comment_params
    params.require(:comment).permit(:body,:commenter,:user_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to blog_path, notice: "Not authorized to destroy this comment" if @comment.nil?
  end
end