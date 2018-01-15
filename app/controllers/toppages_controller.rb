class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @post = current_user.posts.build  # form_for 用
      @posts = current_user.posts.order('created_at DESC').page(params[:page])
    end
  end
end
