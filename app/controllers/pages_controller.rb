class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
  end

  def home
    @page = Page.find_by_slug("home")
    @slide_images = SlideImage.all
    @products = Product.all
    @post = Post.last
  end

  def about
    @page = Page.find_by_slug("about")
    @coaches = Coach.all
  end

  def contact
    @page = Page.find_by_slug("contact")
    @products = Product.all
    @message = Message.new
  end
end

