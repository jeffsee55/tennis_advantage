class ProgramsController < ApplicationController

  def show
    @program = Program.find(params[:id])
  end

  def index
    @anz_programs = Program.where(category: "ANZ Hotshots")
    @competitions = Program.where(category: "Competitions")
    @lessons = Program.where(category: "Lessons")
    @page = Page.find_by_slug("programs")
  end

end
