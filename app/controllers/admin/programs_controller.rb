class Admin::ProgramsController < AdminController
  before_action :set_program, only: [:edit, :show, :update, :destroy]

  def index
    @programs = Program.all.page params[:page]
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.create(program_params)
    redirect_to admin_programs_path, notice: "Program was successfully created."
  end

  def edit
  end

  def show
  end

  def update
    @program.update(program_params)
    redirect_to admin_programs_path, notice: "Program was successfully updated."
  end

  def destroy
    @program.delete
    redirect_to admin_programs_path, alert: "Program was successfully deleted."
  end

  private

    def set_program
      @program = Program.find(params[:id])
    end

    def program_params
      params.require(:program).permit(:name, :description, :image_1, :category)
    end
end
