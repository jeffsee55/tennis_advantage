class Admin::PagesController < AdminController

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    @page.update(page_params)
    redirect_to :back, notice: "Page was successfully updated"
  end

  def index
    @pages = Page.all.alphabetical.page params[:page]
  end

  private

    def page_params
      params.require(:page).permit(:title, :slug, :content_a, :content_b, :content_c, :content_d, :content_e,:content_f)
    end
end

