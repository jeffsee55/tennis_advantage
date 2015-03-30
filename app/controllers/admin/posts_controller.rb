class Admin::PostsController < AdminController
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  def index
    @posts = Post.all.page params[:page]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to admin_posts_path, notice: "Post was successfully created."
  end

  def edit
  end

  def show
  end

  def update
    @post.update(post_params)
    redirect_to admin_posts_path, notice: "Post was successfully updated."
  end

  def destroy
    @post.delete
    redirect_to admin_posts_path, alert: "Post was successfully deleted."
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :image_1)
    end

end
