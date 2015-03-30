class Admin::SlideImagesController < AdminController

  def index
    @slide_images = SlideImage.all
    @slide_image = SlideImage.new
  end

  def new
    @slide_image = SlideImage.new
  end

  def create
    @slide_image = SlideImage.new(slide_image_params)
    if @slide_image.save
      redirect_to admin_slide_images_path
    else
      redirect_to :back, alert: "Problem creating slide image"
    end
  end

  def destroy
    @slide_image = SlideImage.find(params[:id])
    @slide_image.delete
    redirect_to admin_slide_images_path, alert: "Image was successfully deleted"
  end

  private

    def slide_image_params
      params.require(:slide_image).permit(:image)
    end
end
