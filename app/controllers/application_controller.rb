class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :cart_session, :footer, :slide_image

  def cart_session
    @cart_session ||= CartSession.new(session)
  end

  def footer
    @footer = Page.find_by_slug("footer")
  end

  def slide_image
    @slide_image = SlideImage.random_slide
  end
end
