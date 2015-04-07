class Admin::CoachesController < AdminController
  def index
    @coaches = Coach.all.page params[:page]
  end

  def show
    @coach = Coach.find(params[:id])
  end

  def new
    @coach = Coach.new
  end

  def edit
    @coach = Coach.find(params[:id])
  end

  def create
    @coach = Coach.new(coach_params)
    if @coach.save
      redirect_to admin_coaches_path, notice: "Coach was successfully created."
    else
      redirect_to :back, alert: @coach.errors.each { |e| puts e }
    end
  end

  def update
    @coach = Coach.find(params[:id])
    @coach.update(coach_params)
    if @coach.save
      redirect_to admin_coaches_path, notice: "Coach was successfully updated."
    else
      redirect_to admin_coach_path(@coach)
    end
  end

  def destroy
    @coach = Coach.find(params[:id])
    @coach.delete
    redirect_to admin_coaches_path, notice: "Coache was successfully deleted."
  end

  private
    def coach_params
      params.require(:coach).permit(:email, :name, :bio, :phone, :image_1, :contactable, :password)
    end
end
