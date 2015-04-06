class Admin::UsersController < AdminController
  def index
    @users = User.all.page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User was successfully created."
    else
      redirect_to :back, alert: @user.errors.each { |e| puts e }
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      redirect_to admin_user_path(@user)
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :bio, :phone, :image_1, :contactable, :password)
    end
end
