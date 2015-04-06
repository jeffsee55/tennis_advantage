class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
    @page = Page.find_by_slug("posts")
  end

end
