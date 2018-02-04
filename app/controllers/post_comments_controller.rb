class PostCommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.create(post_comment_params)
    @post_comment.user_id = current_user.id
    #@post_comment = current_user.post_comments.build(post_comment_params)
    #@comment = Comment.create(text: comment_params[:text], post_id: comment_params[:post_id], user_id: current_user.id)
    if @post_comment.save
      flash[:success] = "コメントしました。"
      #redirect_to "/posts/#{@comment.post.id}"
      #redirect_to post_comments_path(@post.id)
      #redirect_to :action =>"new"
      redirect_to root_url
    else
      @post_comments = @post.post_comments.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def destroy
    @post_comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  #def set_post_comment
    #@post = Post.find(params[:post_id])
    #@post_comment = @post.post_comments.find(params[:id])
  #end

    # Never trust parameters from the scary internet, only allow the white list through.
  def post_comment_params
    params.require(:post_comment).permit(:user_id, :post_id, :content)
  end
    
  def correct_user
    @post_comment = current_user.post_comments.find_by(id: params[:id])
    unless @post_comment
      redirect_to root_path
    end
  end
end